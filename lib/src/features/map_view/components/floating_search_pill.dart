import 'dart:ui';
import 'package:flutter/material.dart';

class FloatingSearchPill extends StatelessWidget {
  final VoidCallback onTap;

  const FloatingSearchPill({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
          child: Material(
            color: colorScheme.surface.withValues(alpha: 0.9),
            elevation: 8,
            shadowColor: colorScheme.primary.withValues(alpha: 0.2),
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: colorScheme.outline,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        // TODO: Update to use AppLocalizations once generated
                        'Search for places or Plus Codes',
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      height: 24,
                      width: 1,
                      color: colorScheme.outlineVariant,
                      margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                    Icon(
                      Icons.mic,
                      color: colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
