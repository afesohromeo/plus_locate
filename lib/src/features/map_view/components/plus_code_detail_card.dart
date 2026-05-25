import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:plus_locate/plus_locate.dart';
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24.0, sigmaY: 24.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: customColors.surface.withValues(alpha: 0.95),
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
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

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
            loc.selectLocationOnMap,
            style: context.textTheme.bodyMedium?.copyWith(
              color: customColors.black1.withValues(alpha: 0.6),
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
                    loc.currentLocation,
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: customColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    locationResult?.locality ?? loc.unknownLocation,
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: customColors.black1,
                      letterSpacing: -0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    locationResult?.formattedAddress ?? '---',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: customColors.black1.withValues(alpha: 0.6),
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
                color: customColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.share_location,
                color: customColors.primary,
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
              color: customColors.black1.withValues(alpha: 0.05),
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
                        loc.labelPlusCode.toUpperCase(),
                        style: context.textTheme.labelMedium?.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: customColors.black1.withValues(alpha: 0.5),
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
                            style: context.textTheme.headlineLarge?.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: customColors.primary,
                              letterSpacing: -1.0,
                            ),
                          ),
                          if (plusCode?.locality != null)
                            Text(
                              plusCode!.locality!,
                              style: context.textTheme.titleMedium?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color:
                                    customColors.primary.withValues(alpha: 0.8),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.content_copy,
                  color: customColors.black1.withValues(alpha: 0.5),
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
                    loc.labelLatitude.toUpperCase(),
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: customColors.black1.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    locationResult?.latitude?.toStringAsFixed(6) ?? '---',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: customColors.black1,
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
                    loc.labelLongitude.toUpperCase(),
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: customColors.black1.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    locationResult?.longitude?.toStringAsFixed(6) ?? '---',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: customColors.black1,
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
                  backgroundColor: customColors.primary,
                  foregroundColor: customColors.surface,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  elevation: 4,
                ),
                icon: const Icon(Icons.directions, size: 20),
                label: Text(
                  loc.navigate,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: customColors.surface,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: TextButton.icon(
                onPressed: onSavePressed,
                style: TextButton.styleFrom(
                  backgroundColor: customColors.black1.withValues(alpha: 0.05),
                  foregroundColor: customColors.black1,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                icon: const Icon(Icons.bookmark_border, size: 20),
                label: Text(
                  loc.saved,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: customColors.black1,
                  ),
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
                  backgroundColor: customColors.black1.withValues(alpha: 0.05),
                  foregroundColor: customColors.black1,
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
