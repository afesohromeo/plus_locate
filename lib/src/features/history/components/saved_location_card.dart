import 'package:flutter/material.dart';
import 'package:plus_locate/plus_locate.dart';

class SavedLocationCard extends StatelessWidget {
  final SavedCode code;
  final VoidCallback? onTap;
  final VoidCallback onCopy;
  final VoidCallback onShare;
  final VoidCallback onDelete;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback? onLongPress;
  final VoidCallback? onSelectToggle;

  const SavedLocationCard({
    super.key,
    required this.code,
    required this.onTap,
    required this.onCopy,
    required this.onShare,
    required this.onDelete,
    this.isSelectionMode = false,
    this.isSelected = false,
    this.onLongPress,
    this.onSelectToggle,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Material(
        color: customColors.surface,
        borderRadius: BorderRadius.circular(20),
        elevation: 0,
        child: InkWell(
          onTap: isSelectionMode ? onSelectToggle : onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? customColors.primary.withValues(alpha: 0.08)
                  : customColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? customColors.primary
                    : customColors.black1.withValues(alpha: 0.06),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: customColors.black1.withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isSelectionMode)
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 2),
                        child: Icon(
                          isSelected
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          size: 22,
                          color: isSelected
                              ? customColors.primary
                              : customColors.black1.withValues(alpha: 0.4),
                        ),
                      ),
                    Expanded(
                      child: Text(
                        code.locality ?? '---',
                        style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: customColors.black1,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (!isSelectionMode) ...[
                      IconButton(
                        onPressed: onShare,
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          Icons.share,
                          size: 20,
                          color: customColors.black1.withValues(alpha: 0.8),
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert,
                          size: 20,
                          color: customColors.black1.withValues(alpha: 0.8),
                        ),
                        onSelected: (value) {
                          if (value == 'copy') onCopy();
                          if (value == 'delete') onDelete();
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'copy',
                            child: Text(
                              l10n.actionCopy,
                              style: context.textTheme.displayMedium
                                  ?.copyWith(
                                      fontSize: 13,
                                      color: customColors.black1),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text(
                              l10n.actionDelete,
                              style: context.textTheme.displayMedium
                                  ?.copyWith(
                                      fontSize: 13,
                                      color: customColors.black1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: customColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        code.globalCode ?? '---',
                        style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: customColors.primary,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: customColors.black1.withValues(alpha: 0.7),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          formatDate(code.savedAt, withTime: true),
                          style: context.textTheme.displayMedium?.copyWith(
                            fontSize: 12,
                            color: customColors.black1.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  code.address ?? '---',
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
        ),
      ),
    );
  }
}
