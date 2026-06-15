import 'package:flutter/material.dart';
import 'package:plus_locate/src/core/core.dart';
import 'package:plus_locate/src/shared/shared.dart';


/// Stub page — will be replaced with full UI from design screens.
class GeneratePage extends StatelessWidget {
  const GeneratePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        title: Text(
          AppLocalizations.of(context)!.generate,
          style: context.textTheme.displayLarge
              ?.copyWith(color: customColors.surface, fontSize: 18),
        ),
        hasAppbar: true,
      ),
      mobileBody: Center(child: Text(AppLocalizations.of(context)!.generate)),
    );
  }
}
