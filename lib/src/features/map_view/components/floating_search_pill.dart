import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:plus_locate/plus_locate.dart';

class FloatingSearchPill extends StatelessWidget {
  final VoidCallback onTap;

  const FloatingSearchPill({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
          child: Material(
            color: customColors.surface.withValues(alpha: 0.9),
            elevation: 8,
            shadowColor: customColors.primary.withValues(alpha: 0.2),
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
                      color: customColors.black1.withValues(alpha: 0.5),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.searchPlacesOrCodes,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: customColors.black1.withValues(alpha: 0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      height: 24,
                      width: 1,
                      color: customColors.black1.withValues(alpha: 0.1),
                      margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                    Icon(
                      Icons.mic,
                      color: customColors.primary,
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
