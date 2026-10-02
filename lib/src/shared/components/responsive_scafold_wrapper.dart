import 'package:flutter/material.dart';
import 'package:plus_locate/plus_locate.dart';

class ResponsiveScaffoldWrapper extends StatelessWidget {
  final Widget mobileBody;
  final Widget? tabletBody;
  final Widget? desktopBody;
  final ScaffoldWrapperProps props;

  const ResponsiveScaffoldWrapper({
    super.key,
    required this.mobileBody,
    this.tabletBody,
    this.desktopBody,
    required this.props,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: (context, _) => _scaffold(mobileBody),
      tablet: (context, _) => _scaffold(tabletBody ?? mobileBody),
      desktop: (context, _) =>
          _scaffold(desktopBody ?? tabletBody ?? mobileBody),
    );
  }

  Widget _scaffold(Widget body) {
    return ScaffoldWrapper(
      body: body,
      leading: props.leading,
      title: props.title,
      bottom: props.bottom,
      actions: props.actions,
      floatingActionButtonLocation: props.floatingActionButtonLocation,
      bottomNav: props.bottomNav,
      onPressed: props.onPressed,
      floatingButtonpadding: props.floatingButtonPadding,
      buttonIcon: props.buttonIcon,
      buttonColor: props.buttonColor,
      mini: props.mini,
      resizeToAvoidBottomInset: props.resizeToAvoidBottomInset,
      showBottomNav: props.showBottomNav,
      showFloatingButton: props.showFloatingButton,
      hasAppbar: props.hasAppbar,
      appBarBgColor: props.appBarBgColor,
      bgColor: props.bgColor,
      elevation: props.elevation,
      toolBarHeight: props.toolBarHeight,
    );
  }
}
