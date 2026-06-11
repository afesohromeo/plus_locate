import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plus_locate/plus_locate.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MapViewPage extends StatefulWidget {
  const MapViewPage({super.key});

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  final Completer<GoogleMapController> _controller = Completer();

  // Default camera position fallback
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(40.712776, -74.005974),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _determineInitialPosition();
  }

  @override
  void dispose() {
    if (_controller.isCompleted) {
      _controller.future.then((controller) => controller.dispose());
    }
    super.dispose();
  }

  Future<void> _determineInitialPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 3,
      ),
    );
    final latLng = LatLng(position.latitude, position.longitude);

    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16.0));

    if (mounted) {
      context.read<MapViewBloc>().add(
            MapViewEvent.reverseGeocodeLocation(
              latitude: position.latitude,
              longitude: position.longitude,
            ),
          );
    }
  }

  void _onMapTapped(LatLng position) {
    context.read<MapViewBloc>().add(
          MapViewEvent.reverseGeocodeLocation(
            latitude: position.latitude,
            longitude: position.longitude,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return MultiBlocListener(
      listeners: [
        BlocListener<HistoryBloc, HistoryState>(
          listenWhen: (previous, current) =>
              previous.historyActionStatus != current.historyActionStatus &&
              current.flowStep == GenericFlowStep.creatingItem,
          listener: (context, state) async {
            final historyBloc = context.read<HistoryBloc>();
            if (state.historyActionStatus == GenericStatus.success) {
              await DialogUtils.handleSuccess(
                context,
                l10n.msgLocationSaved,
                postActions: [
                  () => historyBloc.add(const HistoryEvent.resetFlowStep()),
                ],
                shouldPopDialog: false,
              );
            } else if (state.historyActionStatus == GenericStatus.failure) {
              if (context.mounted) {
                await DialogUtils.handleFailure(
                  context,
                  state.historyActionErrorMessage ?? l10n.operationError,
                  postActions: [
                    () => historyBloc.add(const HistoryEvent.resetFlowStep()),
                  ],
                  shouldPopDialog: false,
                );
              }
            }
          },
        ),
        BlocListener<MapViewBloc, MapViewState>(
          listenWhen: (previous, current) =>
              previous.focusToken != current.focusToken,
          listener: (context, state) async {
            if (state.currentLatitude == null ||
                state.currentLongitude == null) {
              return;
            }
            final controller = await _controller.future;
            controller.animateCamera(
              CameraUpdate.newLatLngZoom(
                LatLng(state.currentLatitude!, state.currentLongitude!),
                16.0,
              ),
            );
          },
        ),
      ],
      child: ResponsiveScaffoldWrapper(
        props: const ScaffoldWrapperProps(
          hasAppbar: false,
          showDrawer: false,
          showBottomNav: false,
        ),
        mobileBody: Stack(
          children: [
            // 1. Google Map Layer
            BlocBuilder<MapViewBloc, MapViewState>(
              buildWhen: (previous, current) =>
                  previous.currentLatitude != current.currentLatitude ||
                  previous.currentLongitude != current.currentLongitude ||
                  previous.mapType != current.mapType,
              builder: (context, state) {
                final markers = <Marker>{};
                if (state.currentLatitude != null &&
                    state.currentLongitude != null) {
                  markers.add(
                    Marker(
                      markerId: const MarkerId('selected_location'),
                      position: LatLng(
                        state.currentLatitude!,
                        state.currentLongitude!,
                      ),
                    ),
                  );
                }

                return GoogleMap(
                  mapType: state.mapType,
                  initialCameraPosition: _initialPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onTap: _onMapTapped,
                  markers: markers,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  mapToolbarEnabled: false,
                );
              },
            ),

            // 2. Top Floating Search Pill
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 0,
              right: 0,
              child: FloatingSearchPill(
                onTap: () {
                  // TODO: Open Search Bottom Sheet or Page
                },
              ),
            ),

            // 3. Map Action Buttons (Right Aligned)
            // Positioned(
            //   right: 24,
            //   bottom: 300, // Above the detail card
            //   child: MapActionButtons(
            //     onLayersPressed: () {
            //       context
            //           .read<MapViewBloc>()
            //           .add(const MapViewEvent.toggleMapType());
            //     },
            //     onMyLocationPressed: () async {
            //       _determineInitialPosition();
            //     },
            //   ),
            // ),

            // 4. Bottom Detail Card
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BlocBuilder<MapViewBloc, MapViewState>(
                builder: (context, state) {
                  return PlusCodeDetailCard(
                    locationResult: state.locationResult,
                    plusCode: state.selectedPlusCode,
                    status: state.geocodeStatus,
                    onNavigatePressed: () async {
                      if (state.currentLatitude != null &&
                          state.currentLongitude != null) {
                        final url = Uri.parse(
                          'https://www.google.com/maps/dir/?api=1&destination=${state.currentLatitude},${state.currentLongitude}',
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          if (context.mounted) {
                            await DialogUtils.handleFailure(
                              context,
                              l10n.operationError,
                            );
                          }
                        }
                      }
                    },
                    onSavePressed: () {
                      if (state.selectedPlusCode != null) {
                        final savedCode = SavedCode(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          globalCode: state.selectedPlusCode?.globalCode,
                          localCode: state.selectedPlusCode?.localCode,
                          latitude: state.currentLatitude,
                          longitude: state.currentLongitude,
                          locality: state.locationResult?.locality,
                          address: state.locationResult?.formattedAddress,
                          savedAt: DateTime.now(),
                        );
                        context.read<HistoryBloc>().add(
                              HistoryEvent.saveCode(code: savedCode),
                            );
                      }
                    },
                    onSharePressed: () {
                      final plusCodeVal =
                          state.selectedPlusCode?.globalCode ?? '---';
                      final latVal =
                          state.currentLatitude?.toStringAsFixed(6) ?? '---';
                      final lngVal =
                          state.currentLongitude?.toStringAsFixed(6) ?? '---';
                      final addressVal =
                          state.locationResult?.formattedAddress ?? '---';

                      final shareText = l10n.shareLocationText(
                        plusCodeVal,
                        latVal,
                        lngVal,
                        addressVal,
                      );

                      Share.share(shareText);
                    },
                    onCopyPlusCode: () async {
                      final code = state.selectedPlusCode?.globalCode;
                      if (code != null) {
                        Clipboard.setData(ClipboardData(text: code));
                        if (context.mounted) {
                          await DialogUtils.handleSuccess(
                            context,
                            l10n.msgCodeCopied,
                          );
                        }
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
