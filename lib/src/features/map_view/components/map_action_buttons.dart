import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:plus_locate/plus_locate.dart';

class MapActionButtons extends StatelessWidget {
  final VoidCallback onLayersPressed;
  final VoidCallback onMyLocationPressed;

  const MapActionButtons({
    super.key,
    required this.onLayersPressed,
    required this.onMyLocationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Layers Button (Glassmorphism)
        ClipRRect(
          borderRadius: BorderRadius.circular(28.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Material(
              color: customColors.surface.withValues(alpha: 0.9),
              elevation: 4,
              shadowColor: Colors.black.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(28.0),
              child: InkWell(
                onTap: onLayersPressed,
                borderRadius: BorderRadius.circular(28.0),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(
                    Icons.layers_outlined,
                    color: customColors.black1.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // My Location Button (Solid Primary)
        Material(
          color: customColors.primary,
          elevation: 8,
          shadowColor: customColors.primary.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(28.0),
          child: InkWell(
            onTap: onMyLocationPressed,
            borderRadius: BorderRadius.circular(28.0),
            child: const SizedBox(
              width: 56,
              height: 56,
              child: Icon(
                Icons.my_location,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
