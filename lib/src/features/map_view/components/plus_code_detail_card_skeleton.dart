import 'package:flutter/material.dart';
import 'package:plus_locate/plus_locate.dart';

/// Loading placeholder shaped like [PlusCodeDetailCard]'s content.
class PlusCodeDetailCardSkeleton extends StatelessWidget {
  /// Content only, for use inside a card surface.
  const PlusCodeDetailCardSkeleton({super.key, this.compact = false})
      : _surfaceMargin = null;

  /// The skeleton on its own [DetailCardSurface].
  const PlusCodeDetailCardSkeleton.card({
    super.key,
    this.compact = false,
    EdgeInsetsGeometry margin = const EdgeInsets.all(12),
  }) : _surfaceMargin = margin;

  /// Matches the collapsed Map-tab card instead of the full details.
  final bool compact;
  final EdgeInsetsGeometry? _surfaceMargin;

  @override
  Widget build(BuildContext context) {
    final skeleton = Semantics(
      label: AppLocalizations.of(context)!.loading,
      child: ShimmerSkeleton(
        child: compact ? const _CompactShape() : const _FullShape(),
      ),
    );

    final margin = _surfaceMargin;
    return margin == null
        ? skeleton
        : DetailCardSurface(margin: margin, child: skeleton);
  }
}

class _CompactShape extends StatelessWidget {
  const _CompactShape();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(width: 90, height: 12),
                SizedBox(height: 8),
                SkeletonBox(width: 160, height: 22),
              ],
            ),
          ),
          SizedBox(width: 12),
          SkeletonBox.circle(size: 48),
        ],
      ),
    );
  }
}

class _FullShape extends StatelessWidget {
  const _FullShape();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title, locality, two address lines
        SkeletonBox(width: 130, height: 16),
        SizedBox(height: 10),
        SkeletonBox(width: 170, height: 14),
        SizedBox(height: 8),
        SkeletonBox(height: 12),
        SizedBox(height: 6),
        SkeletonBox(width: 200, height: 12),
        SizedBox(height: 14),
        // Plus Code block
        SkeletonBox(height: 64, radius: 16),
        SizedBox(height: 18),
        // Coordinates
        Row(
          children: [
            Expanded(child: _CoordinateShape()),
            Expanded(child: _CoordinateShape()),
          ],
        ),
        SizedBox(height: 14),
        // Navigate + icon actions
        Row(
          children: [
            Expanded(child: SkeletonBox(height: 44, radius: 22)),
            SizedBox(width: 12),
            SkeletonBox.circle(size: 44),
            SizedBox(width: 12),
            SkeletonBox.circle(size: 44),
          ],
        ),
      ],
    );
  }
}

class _CoordinateShape extends StatelessWidget {
  const _CoordinateShape();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonBox(width: 60, height: 12),
        SizedBox(height: 6),
        SkeletonBox(width: 90, height: 12),
      ],
    );
  }
}
