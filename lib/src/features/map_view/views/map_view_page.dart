import 'package:flutter/material.dart';
import 'package:plus_locate/src/core/core.dart';
import 'package:plus_locate/src/shared/shared.dart';


/// Stub page — will be replaced with full UI from design screens.
class MapViewPage extends StatelessWidget {
  const MapViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        title: Text(AppLocalizations.of(context)!.mapView),
        hasAppbar: true,
      ),
      mobileBody: Center(child: Text(AppLocalizations.of(context)!.mapView)),
    );
  }
}
