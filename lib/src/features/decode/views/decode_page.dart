import 'package:flutter/material.dart';
import 'package:plus_locate/src/core/core.dart';
import 'package:plus_locate/src/shared/shared.dart';


/// Stub page — will be replaced with full UI from design screens.
class DecodePage extends StatelessWidget {
  const DecodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        title: Text(AppLocalizations.of(context)!.decode),
        hasAppbar: true,
      ),
      mobileBody: Center(child: Text(AppLocalizations.of(context)!.decode)),
    );
  }
}
