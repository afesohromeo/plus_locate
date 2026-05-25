import 'package:flutter/material.dart';
import 'package:plus_locate/plus_locate.dart';

class CenterMapPin extends StatelessWidget {
  const CenterMapPin({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        // Shift it up so the point of the pin is at the exact center
        child: FractionalTranslation(
          translation: const Offset(0.0, -0.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: customColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: customColors.surface,
                    width: 3.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: customColors.black1.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.location_on,
                  color: customColors.surface,
                  size: 28,
                ),
              ),
              // The shadow/stick below the pin
              Transform.translate(
                offset: const Offset(0, -4),
                child: Container(
                  height: 16,
                  width: 4,
                  decoration: BoxDecoration(
                    color: customColors.primary.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
