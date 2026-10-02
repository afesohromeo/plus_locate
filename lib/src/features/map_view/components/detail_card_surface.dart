import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plus_locate/plus_locate.dart';

/// The frosted, rounded surface shared by [PlusCodeDetailCard] and
/// [PlusCodeDetailCardSkeleton].
class DetailCardSurface extends StatelessWidget {
  const DetailCardSurface({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.all(12),
  });

  final Widget child;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24.0, sigmaY: 24.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: customColors.surface.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(
                color: customColors.surface.withValues(alpha: 0.4),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: customColors.black1.withValues(alpha: 0.1),
                  blurRadius: 32,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
