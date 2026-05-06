import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plus_locate/src/features/map_view/map_view.dart';
import 'package:plus_locate/src/shared/shared.dart';

class MapViewPage extends StatefulWidget {
  const MapViewPage({super.key});

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  final Completer<GoogleMapController> _controller = Completer();

  // Default camera position: Center of New York (per design reference)
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(40.712776, -74.005974),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    // Fetch initial location (or let the map do it once initialized)
  }

  void _onCameraIdle() async {
    final controller = await _controller.future;
    final bounds = await controller.getVisibleRegion();
    // The center is simply the midpoint between southwest and northeast
    final centerLat =
        (bounds.northeast.latitude + bounds.southwest.latitude) / 2;
    final centerLng =
        (bounds.northeast.longitude + bounds.southwest.longitude) / 2;

    if (mounted) {
      context.read<MapViewBloc>().add(
            MapViewEvent.reverseGeocodeLocation(
              latitude: centerLat,
              longitude: centerLng,
            ),
          );
    }
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
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraIdle: _onCameraIdle,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            mapToolbarEnabled: false,
          ),

          // 2. Center Fixed Map Pin
          const CenterMapPin(),

          // 3. Top Floating Search Pill
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

          // // 4. Map Action Buttons (Right Aligned)
          // Positioned(
          //   right: 24,
          //   bottom: 300, // Above the detail card
          //   child: MapActionButtons(
          //     onLayersPressed: () {
          //       // TODO: Toggle map type
          //     },
          //     onMyLocationPressed: () async {
          //       final controller = await _controller.future;
          //       // For now, jump back to initial position.
          //       // Later: fetch real device location using Geolocator
          //       controller.animateCamera(
          //         CameraUpdate.newCameraPosition(_initialPosition),
          //       );
          //     },
          //   ),
          // ),

          // 5. Bottom Detail Card
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
