import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plus_locate/src/core/core.dart';
import 'package:plus_locate/src/features/map_view/map_view.dart';
import 'package:plus_locate/src/shared/shared.dart';

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
    return ResponsiveScaffoldWrapper(
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
                previous.currentLongitude != current.currentLongitude,
            builder: (context, state) {
              final markers = <Marker>{};
              if (state.currentLatitude != null &&
                  state.currentLongitude != null) {
                markers.add(
                  Marker(
                    markerId: const MarkerId('selected_location'),
                    position:
                        LatLng(state.currentLatitude!, state.currentLongitude!),
                  ),
                );
              }
              // return Container();

              return GoogleMap(
                mapType: MapType.normal,
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

          // // 3. Map Action Buttons (Right Aligned)
          // Positioned(
          //   right: 24,
          //   bottom: 300, // Above the detail card
          //   child: MapActionButtons(
          //     onLayersPressed: () {
          //       // TODO: Toggle map type
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
                  onNavigatePressed: () {
                    // TODO: Open Maps for navigation
                  },
                  onSavePressed: () {
                    // TODO: Save to history
                  },
                  onSharePressed: () {
                    // TODO: Share location text
                  },
                  onCopyPlusCode: () {
                    // TODO: Copy Plus Code to clipboard
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
