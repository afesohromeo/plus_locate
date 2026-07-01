import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:plus_locate/plus_locate.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<HistoryBloc, HistoryState>(
      buildWhen: (previous, current) =>
          previous.isSelectionMode != current.isSelectionMode ||
          previous.selectedIds != current.selectedIds,
      builder: (context, state) {
        final titleStyle = context.textTheme.displayLarge
            ?.copyWith(color: customColors.surface, fontSize: 18);

        return ResponsiveScaffoldWrapper(
          props: state.isSelectionMode
              ? ScaffoldWrapperProps(
                  hasAppbar: true,
                  appBarBgColor: customColors.primary,
                  elevation: 0,
                  showDrawer: false,
                  showBottomNav: false,
                  showFloatingButton: false,
                  resizeToAvoidBottomInset: true,
                  leading: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => context
                        .read<HistoryBloc>()
                        .add(const HistoryEvent.exitSelectionMode()),
                  ),
                  title: Text(
                    l10n.selectedCount(state.selectedIds.length),
                    style: titleStyle,
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.select_all, color: Colors.white),
                      tooltip: l10n.selectAll,
                      onPressed: () => context
                          .read<HistoryBloc>()
                          .add(const HistoryEvent.selectAllCodes()),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: () => _confirmAndDeleteSelected(
                          context, l10n, state.selectedIds.length),
                    ),
                  ],
                )
              : ScaffoldWrapperProps(
                  hasAppbar: true,
                  appBarBgColor: customColors.primary,
                  elevation: 0,
                  showDrawer: false,
                  showBottomNav: false,
                  showFloatingButton: false,
                  resizeToAvoidBottomInset: true,
                  leading:
                      const Icon(Icons.location_history, color: Colors.white),
                  title: Text(l10n.savedLocations, style: titleStyle),
                ),
          mobileBody: const _HistoryBody(),
          tabletBody: const _HistoryBody(),
          desktopBody: const _HistoryBody(),
        );
      },
    );
  }

  Future<void> _confirmAndDeleteSelected(
    BuildContext context,
    AppLocalizations l10n,
    int count,
  ) async {
    final historyBloc = context.read<HistoryBloc>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.confirmDeleteMultipleTitle,
            style: context.textTheme.titleLarge),
        content: Text(
          l10n.confirmDeleteMultipleMessage(count),
          style: context.textTheme.displayMedium?.copyWith(
              fontSize: 14, color: customColors.black1.withValues(alpha: .7)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              l10n.cancel,
              style: context.textTheme.displayLarge?.copyWith(fontSize: 14),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              l10n.actionDelete,
              style: context.textTheme.displayLarge?.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      historyBloc.add(const HistoryEvent.deleteSelectedCodes());
    }
  }
}

class _HistoryBody extends StatelessWidget {
  const _HistoryBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<HistoryBloc, HistoryState>(
      listenWhen: (previous, current) =>
          previous.historyActionStatus != current.historyActionStatus &&
          current.flowStep == GenericFlowStep.deletingItem,
      listener: (context, state) async {
        final historyBloc = context.read<HistoryBloc>();
        if (state.historyActionStatus == GenericStatus.success) {
          final deletedCount = state.lastDeletedCount;
          await DialogUtils.handleSuccess(
            context,
            deletedCount != null && deletedCount > 1
                ? l10n.msgCodesDeleted(deletedCount)
                : l10n.msgCodeDeleted,
            postActions: [
              () => historyBloc.add(const HistoryEvent.resetFlowStep()),
            ],
          );
        } else if (state.historyActionStatus == GenericStatus.failure) {
          if (context.mounted) {
            await DialogUtils.handleFailure(
              context,
              state.historyActionErrorMessage ?? l10n.operationError,
              postActions: [
                () => historyBloc.add(const HistoryEvent.resetFlowStep()),
              ],
            );
          }
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: SearchInputField(
                bgColor: customColors.surface,
                labelColor: customColors.black1.withValues(alpha: .7),
                labelText: l10n.search,
                onChanged: (query) {
                  final historyBloc = context.read<HistoryBloc>();
                  if (query.trim().isEmpty) {
                    historyBloc.add(const HistoryEvent.fetchSavedCodes());
                  } else {
                    historyBloc.add(HistoryEvent.searchCodes(query: query));
                  }
                },
              ),
            ),
            Expanded(child: _buildContent(context, state, l10n)),
          ],
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    HistoryState state,
    AppLocalizations l10n,
  ) {
    if (state.historyStatus == GenericStatus.loading) {
      return LoadingWidget(loadingText: l10n.loading);
    }

    if (state.historyStatus == GenericStatus.failure) {
      return ErrorrWidget(
        errorMessage: state.historyErrorMessage ?? l10n.operationError,
        refreshText: l10n.refresh,
        onPressed: () => context
            .read<HistoryBloc>()
            .add(const HistoryEvent.fetchSavedCodes()),
      );
    }

    if (state.savedCodes.isEmpty) {
      return EmptyWidget(
        emptyText: l10n.noData,
        onPressed: () => context
            .read<HistoryBloc>()
            .add(const HistoryEvent.fetchSavedCodes()),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: state.savedCodes.length,
      itemBuilder: (context, index) {
        final code = state.savedCodes[index];
        final codeId = code.id;
        return SavedLocationCard(
          code: code,
          isSelectionMode: state.isSelectionMode,
          isSelected: codeId != null && state.selectedIds.contains(codeId),
          onLongPress: codeId != null
              ? () => context
                  .read<HistoryBloc>()
                  .add(HistoryEvent.enterSelectionMode(id: codeId))
              : null,
          onSelectToggle: codeId != null
              ? () => context
                  .read<HistoryBloc>()
                  .add(HistoryEvent.toggleItemSelection(id: codeId))
              : null,
          onTap: code.hasCoordinates
              ? () {
                  context.read<MapViewBloc>().add(
                        MapViewEvent.focusOnLocation(
                          latitude: code.latitude!,
                          longitude: code.longitude!,
                          plusCode: PlusCode(
                            globalCode: code.globalCode,
                            localCode: code.localCode,
                            latitude: code.latitude,
                            longitude: code.longitude,
                            locality: code.locality,
                          ),
                          locationResult: LocationResult(
                            formattedAddress: code.address,
                            latitude: code.latitude,
                            longitude: code.longitude,
                            locality: code.locality,
                          ),
                        ),
                      );
                  context.goNamed(mapViewRouteName);
                }
              : null,
          onCopy: () async {
            final globalCode = code.globalCode;
            if (globalCode != null) {
              Clipboard.setData(ClipboardData(text: globalCode));
              await DialogUtils.handleSuccess(context, l10n.msgCodeCopied);
            }
          },
          onShare: () {
            final shareText = l10n.shareLocationText(
              code.globalCode ?? '---',
              code.latitude?.toStringAsFixed(6) ?? '---',
              code.longitude?.toStringAsFixed(6) ?? '---',
              code.locality ?? '---',
            );
            Share.share(shareText);
          },
          onDelete: () async {
            final historyBloc = context.read<HistoryBloc>();
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (dialogContext) => AlertDialog(
                title: Text(l10n.confirmDeleteTitle,
                    style: context.textTheme.titleLarge),
                content: Text(
                  l10n.confirmDeleteMessage,
                  style: context.textTheme.displayMedium?.copyWith(
                      fontSize: 14,
                      color: customColors.black1.withValues(alpha: .7)),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                    child: Text(
                      l10n.cancel,
                      style: context.textTheme.displayLarge?.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(true),
                    child: Text(
                      l10n.actionDelete,
                      style: context.textTheme.displayLarge?.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            );

            if (confirmed == true && code.id != null) {
              historyBloc.add(HistoryEvent.deleteCode(id: code.id!));
            }
          },
        );
      },
    );
  }
}
