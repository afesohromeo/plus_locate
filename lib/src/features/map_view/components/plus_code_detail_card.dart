import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:plus_locate/src/domain/models/location_result.dart';
import 'package:plus_locate/src/domain/models/plus_code.dart';
import 'package:plus_locate/src/shared/utils/status.dart';

class PlusCodeDetailCard extends StatelessWidget {
  final LocationResult? locationResult;
  final PlusCode? plusCode;
  final GenericStatus status;
  final VoidCallback onNavigatePressed;
  final VoidCallback onSavePressed;
  final VoidCallback onSharePressed;
  final VoidCallback onCopyPlusCode;

  const PlusCodeDetailCard({
    super.key,
    this.locationResult,
    this.plusCode,
    required this.status,
    required this.onNavigatePressed,
    required this.onSavePressed,
    required this.onSharePressed,
    required this.onCopyPlusCode,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24.0, sigmaY: 24.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.4),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 32,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: _buildContent(context, colorScheme),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ColorScheme colorScheme) {
    if (status == GenericStatus.loading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (locationResult == null && plusCode == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Select a location on the map',
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card Header
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CURRENT LOCATION',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    locationResult?.locality ?? 'Unknown Location',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                      letterSpacing: -0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    locationResult?.formattedAddress ?? '---',
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.share_location,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Plus Code Highlight
        InkWell(
          onTap: onCopyPlusCode,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PLUS CODE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.outline,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        children: [
                          Text(
                            plusCode?.globalCode ?? '---',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: colorScheme.primary,
                              letterSpacing: -1.0,
                            ),
                          ),
                          if (plusCode?.locality != null)
                            Text(
                              plusCode!.locality!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color:
                                    colorScheme.primary.withValues(alpha: 0.8),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.content_copy,
                  color: colorScheme.outline,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Coordinates Grid
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LATITUDE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    locationResult?.latitude?.toStringAsFixed(6) ?? '---',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LONGITUDE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    locationResult?.longitude?.toStringAsFixed(6) ?? '---',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),

        // Action Buttons
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: onNavigatePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  elevation: 4,
                ),
                icon: const Icon(Icons.directions, size: 20),
                label: const Text(
                  'Navigate',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: TextButton.icon(
                onPressed: onSavePressed,
                style: TextButton.styleFrom(
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  foregroundColor: colorScheme.onSurface,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                icon: const Icon(Icons.bookmark_border, size: 20),
                label: const Text(
                  'Saved',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 56,
              height: 56,
              child: TextButton(
                onPressed: onSharePressed,
                style: TextButton.styleFrom(
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  foregroundColor: colorScheme.onSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: const Icon(Icons.share),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
