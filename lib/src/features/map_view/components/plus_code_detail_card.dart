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

  /// Makes the card collapsible (Map tab): [expanded] picks the compact
  /// summary or the full details, and dragging or tapping the handle asks
  /// for the other state. When null the card always shows full details.
  final ValueChanged<bool>? onExpandedChanged;
  final bool expanded;

  /// Space around the card. The Search tab passes zero because its page
  /// is already padded.
  final EdgeInsetsGeometry margin;

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
    this.onExpandedChanged,
    this.expanded = true,
    this.margin = const EdgeInsets.all(12),
  });

  bool get _isCollapsible => onExpandedChanged != null;

  bool get _hasResult => locationResult != null || plusCode != null;

  void _onVerticalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity < -50 && !expanded) onExpandedChanged!(true);
    if (velocity > 50 && expanded) onExpandedChanged!(false);
  }

  @override
  Widget build(BuildContext context) {
    return DetailCardSurface(
      margin: margin,
      child: GestureDetector(
        onVerticalDragEnd:
            _isCollapsible && _hasResult ? _onVerticalDragEnd : null,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isCollapsible &&
                  _hasResult &&
                  status != GenericStatus.loading)
                _buildHandle(context),
              _buildContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Semantics(
      button: true,
      label: expanded ? l10n.hideDetails : l10n.showDetails,
      child: InkWell(
        onTap: () => onExpandedChanged!(!expanded),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: customColors.black1.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Collapsed Map-tab summary: locality, Plus Code (tap to copy), Navigate.
  Widget _buildCompact(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onCopyPlusCode,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locationResult?.locality ?? l10n.unknownLocation,
                    style: context.textTheme.displayLarge?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: customColors.black1.withValues(alpha: 0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          plusCode?.globalCode ?? '---',
                          style: context.textTheme.displayLarge?.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: customColors.primary,
                            letterSpacing: -1.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.content_copy,
                        size: 18,
                        color: customColors.black1.withValues(alpha: 0.6),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          iconSize: 22,
          tooltip: l10n.navigate,
          onPressed: onNavigatePressed,
          style: IconButton.styleFrom(
            backgroundColor: customColors.primary,
            foregroundColor: customColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          icon: const Icon(Icons.directions),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (status == GenericStatus.loading) {
      return PlusCodeDetailCardSkeleton(compact: _isCollapsible && !expanded);
    }

    if (!_hasResult) {
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

    if (_isCollapsible && !expanded) return _buildCompact(context);

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
                    (locationResult?.latitude ?? plusCode?.latitude)
                            ?.toStringAsFixed(6) ??
                        '---',
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
                    (locationResult?.longitude ?? plusCode?.longitude)
                            ?.toStringAsFixed(6) ??
                        '---',
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

        // Action Buttons: one labelled primary action, the rest as icons so
        // the row fits narrow screens even with View on Map.
        Row(
          children: [
            Expanded(
              child: PrimaryButton(
                onPressed: onNavigatePressed,
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
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          l10n.navigate,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.displayLarge?.copyWith(
                            color: customColors.surface,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            _actionIconButton(
              icon: Icons.bookmark_border,
              tooltip: l10n.actionSave,
              onPressed: onSavePressed,
            ),
            const SizedBox(width: 8),
            _actionIconButton(
              icon: Icons.share,
              tooltip: l10n.actionShare,
              onPressed: onSharePressed,
            ),
            if (onViewOnMapPressed != null) ...[
              const SizedBox(width: 8),
              _actionIconButton(
                icon: Icons.map_outlined,
                tooltip: l10n.viewOnMap,
                onPressed: onViewOnMapPressed!,
                highlighted: true,
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _actionIconButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
    bool highlighted = false,
  }) {
    return IconButton(
      iconSize: 20,
      tooltip: tooltip,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: highlighted
            ? customColors.primary.withValues(alpha: 0.1)
            : customColors.black1.withValues(alpha: 0.05),
        foregroundColor:
            highlighted ? customColors.primary : customColors.black1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      icon: Icon(icon),
    );
  }
}
