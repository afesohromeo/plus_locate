import 'package:flutter/material.dart';

class CenterMapPin extends StatelessWidget {
  const CenterMapPin({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.white,
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
                    color: colorScheme.primary.withValues(alpha: 0.4),
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
