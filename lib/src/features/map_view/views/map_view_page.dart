import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plus_locate/plus_locate.dart';
import 'package:url_launcher/url_launcher.dart';

class MapViewPage extends StatefulWidget {
  const MapViewPage({super.key});

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  final Completer<GoogleMapController> _controller = Completer();

  /// Height of the detail card, used as the map's bottom padding so the
  /// Google logo and the camera center stay in the visible part of the map.
  double _detailCardHeight = 0;

  static const _markerAsset = 'assets/images/PlusLocate_3.png';
  static const _markerHeight = 32.0;

  /// The pin's tip, measured from the image: it sits at 93.9% of the height
  /// (transparent padding below), not at the bottom edge.
  static const _markerAnchor = Offset(0.5, 0.939);

  /// Brand pin once loaded; the default pin until then or if loading fails.
  BitmapDescriptor _markerIcon = BitmapDescriptor.defaultMarker;
  Offset _markerIconAnchor = const Offset(0.5, 1.0);

  // Default camera position fallback
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(40.712776, -74.005974),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _loadMarkerIcon();
    _determineInitialPosition();
  }

  Future<void> _loadMarkerIcon() async {
    try {
      final icon = await BitmapDescriptor.asset(
        const ImageConfiguration(),
        _markerAsset,
        height: _markerHeight,
      );
      if (!mounted) return;
      setState(() {
        _markerIcon = icon;
        _markerIconAnchor = _markerAnchor;
      });
    } catch (e) {
      log('Brand marker failed to load, keeping the default pin: $e');
    }
  }

  @override
  void dispose() {
    if (_controller.isCompleted) {
      _controller.future.then((controller) => controller.dispose());
    }
    super.dispose();
  }

  /// Centers the map on the device. When [userInitiated] (the re-center
  /// button), explains any failure and opens the relevant settings; on
  /// startup it fails silently and the map keeps its default position.
  Future<void> _determineInitialPosition({bool userInitiated = false}) async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (userInitiated) {
        await _showLocationError(
          (l10n) => l10n.errorLocationServiceDisabled,
          openSettings: Geolocator.openLocationSettings,
        );
      }
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (userInitiated) {
          await _showLocationError(
            (l10n) => l10n.errorLocationPermissionDenied,
          );
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (userInitiated) {
        await _showLocationError(
          (l10n) => l10n.errorLocationPermissionDenied,
          openSettings: Geolocator.openAppSettings,
        );
      }
      return;
    }

    final Position position;
    try {
      position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 3,
        ),
      );
    } catch (e) {
      if (userInitiated) {
        await _showLocationError((l10n) => l10n.errorLocationUnavailable);
      }
      return;
    }
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

  /// The message is resolved lazily: this class also runs location lookup
  /// from initState, where localizations can't be read yet.
  Future<void> _showLocationError(
    String Function(AppLocalizations l10n) message, {
    Future<bool> Function()? openSettings,
  }) async {
    if (!mounted) return;
    await DialogUtils.handleFailure(
      context,
      message(AppLocalizations.of(context)!),
      postActions: [if (openSettings != null) () => openSettings()],
    );
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
                      icon: _markerIcon,
                      anchor: _markerIconAnchor,
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
                  padding: EdgeInsets.only(bottom: _detailCardHeight),
                );
              },
            ),

            // 2. Top Floating Search Pill
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 0,
              right: 0,
              child: FloatingSearchPill(
                onTap: () => context.goNamed(searchRouteName),
              ),
            ),

            // 3. Map Action Buttons + Bottom Detail Card
            // Stacked in one column so the buttons always sit right above
            // the card, whatever its current height.
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: MapActionButtons(
                      onLayersPressed: () => context
                          .read<MapViewBloc>()
                          .add(const MapViewEvent.toggleMapType()),
                      onMyLocationPressed: () =>
                          _determineInitialPosition(userInitiated: true),
                    ),
                  ),
                  MeasureSize(
                    onChange: (size) {
                      if (mounted && size.height != _detailCardHeight) {
                        setState(() => _detailCardHeight = size.height);
                      }
                    },
                    child: BlocBuilder<MapViewBloc, MapViewState>(
                      builder: (context, state) {
                        return PlusCodeDetailCard(
                          locationResult: state.locationResult,
                          plusCode: state.selectedPlusCode,
                          status: state.geocodeStatus,
                          expanded: state.isDetailCardExpanded,
                          onExpandedChanged: (expanded) => context
                              .read<MapViewBloc>()
                              .add(MapViewEvent.setDetailCardExpanded(
                                expanded: expanded,
                              )),
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
                                id: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                globalCode: state.selectedPlusCode?.globalCode,
                                localCode: state.selectedPlusCode?.localCode,
                                latitude: state.currentLatitude,
                                longitude: state.currentLongitude,
                                locality: state.locationResult?.locality,
                                address: state.locationResult?.formattedAddress,
                                savedAt: DateTime.now(),
                              );
                              saveLocationWithLabel(context, savedCode);
                            }
                          },
                          onSharePressed: () {
                            final globalCode =
                                state.selectedPlusCode?.globalCode;
                            final savedLabel = context
                                .read<HistoryBloc>()
                                .state
                                .savedCodes
                                .where((c) => c.globalCode == globalCode)
                                .firstOrNull
                                ?.label;

                            showShareLocationSheet(
                              context,
                              ShareableLocation(
                                plusCode: globalCode,
                                latitude: state.currentLatitude,
                                longitude: state.currentLongitude,
                                address: state.locationResult?.formattedAddress,
                                label: savedLabel,
                              ),
                            );
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
          ],
        ),
      ),
    );
  }
}
