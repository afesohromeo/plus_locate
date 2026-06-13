import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:plus_locate/plus_locate.dart';

class PlusCodeDetailCard extends StatelessWidget {
  final LocationResult? locationResult;
  final PlusCode? plusCode;
  final GenericStatus status;
  final VoidCallback onNavigatePressed;
  final VoidCallback onSavePressed;
  final VoidCallback onSharePressed;
  final VoidCallback onCopyPlusCode;

  /// Header title. Defaults to [AppLocalizations.currentLocation] when null
  /// — used by the Map tab. The Search tab passes its own title.
  final String? title;

  /// When provided, shows a "View on Map" icon button in the action row.
  final VoidCallback? onViewOnMapPressed;

  const PlusCodeDetailCard({
    super.key,
    this.locationResult,
    this.plusCode,
    required this.status,
    required this.onNavigatePressed,
    required this.onSavePressed,
    required this.onSharePressed,
    required this.onCopyPlusCode,
    this.title,
    this.onViewOnMapPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
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
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
            l10n.selectLocationOnMap,
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
                    title ?? l10n.currentLocation,
                    style: context.textTheme.displayLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: customColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    locationResult?.locality ?? l10n.unknownLocation,
                    style: context.textTheme.displayLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: customColors.black1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    locationResult?.formattedAddress ?? '---',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: customColors.black1.withValues(alpha: 0.8),
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
        const SizedBox(height: 8),

        // Plus Code Highlight
        InkWell(
          onTap: onCopyPlusCode,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(12),
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
                        l10n.labelPlusCode.toUpperCase(),
                        style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: customColors.black1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        children: [
                          Text(
                            plusCode?.globalCode ?? '---',
                            style: context.textTheme.displayLarge?.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: customColors.primary,
                              letterSpacing: -1.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.content_copy,
                  color: customColors.black1.withValues(alpha: 0.8),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),

        // Coordinates Grid
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.labelLatitude,
                    style: context.textTheme.displaySmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: customColors.black1,
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
                    l10n.labelLongitude,
                    style: context.textTheme.displaySmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: customColors.black1,
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
        const SizedBox(height: 12),

        // Action Buttons
        Row(
          children: [
            Expanded(
              flex: 2,
              child: PrimaryButton(
                onPressed: onNavigatePressed,
                // height: 50,
                inkRaduis: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.directions,
                      size: 20,
                      color: customColors.surface,
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        l10n.navigate,
                        style: context.textTheme.displayLarge?.copyWith(
                            color: customColors.surface, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: PrimaryButton(
                onPressed: onSavePressed,
                withBg: false,
                buttonColor: customColors.black1.withValues(alpha: 0.05),
                borderColor: Colors.transparent,
                inkRaduis: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bookmark_border,
                        size: 20,
                        color: customColors.black1,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.saved,
                        style: context.textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: customColors.black1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              iconSize: 20,
              onPressed: onSharePressed,
              style: IconButton.styleFrom(
                backgroundColor: customColors.black1.withValues(alpha: 0.05),
                foregroundColor: customColors.black1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: EdgeInsets.zero,
              ),
              icon: const Icon(Icons.share),
            ),
            if (onViewOnMapPressed != null) ...[
              const SizedBox(width: 12),
              IconButton(
                iconSize: 20,
                onPressed: onViewOnMapPressed,
                style: IconButton.styleFrom(
                  backgroundColor:
                      customColors.primary.withValues(alpha: 0.1),
                  foregroundColor: customColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  padding: EdgeInsets.zero,
                ),
                icon: const Icon(Icons.map_outlined),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
