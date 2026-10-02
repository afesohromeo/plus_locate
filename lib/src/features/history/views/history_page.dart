import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_locate/plus_locate.dart';
import 'package:share_plus/share_plus.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<HistoryBloc, HistoryState>(
      buildWhen: (previous, current) =>
          previous.isSelectionMode != current.isSelectionMode ||
          previous.selectedIds != current.selectedIds ||
          previous.savedCodes.isEmpty != current.savedCodes.isEmpty,
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
                      icon: const Icon(Icons.share, color: Colors.white),
                      tooltip: l10n.actionShare,
                      onPressed: () => _shareSelected(context, state),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      tooltip: l10n.actionDelete,
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
                  actions: [
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      tooltip:
                          MaterialLocalizations.of(context).showMenuTooltip,
                      onSelected: (value) {
                        if (value == 'export') {
                          context
                              .read<HistoryBloc>()
                              .add(const HistoryEvent.exportSavedCodes());
                        }
                        if (value == 'import') _pickAndImport(context, l10n);
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'export',
                          enabled: state.savedCodes.isNotEmpty,
                          child: Text(l10n.actionExport),
                        ),
                        PopupMenuItem(
                          value: 'import',
                          child: Text(l10n.actionImport),
                        ),
                      ],
                    ),
                  ],
                ),
          mobileBody: const _HistoryBody(),
          tabletBody: const _HistoryBody(),
          desktopBody: const _HistoryBody(),
        );
      },
    );
  }

  /// Shares the selected locations, in list order. Selection mode ends once
  /// an option is picked; dismissing the sheet keeps the selection.
  Future<void> _shareSelected(BuildContext context, HistoryState state) async {
    final historyBloc = context.read<HistoryBloc>();
    final selectedIds = Set<String>.of(state.selectedIds);
    final locations = state.savedCodes
        .where((code) => selectedIds.contains(code.id))
        .map(ShareableLocation.fromSavedCode)
        .toList();
    if (locations.isEmpty) return;

    final shared = await showShareLocationsSheet(
      context,
      locations,
      onShareAsFile: () =>
          historyBloc.add(HistoryEvent.exportSavedCodes(ids: selectedIds)),
    );
    if (shared) historyBloc.add(const HistoryEvent.exitSelectionMode());
  }

  Future<void> _pickAndImport(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final historyBloc = context.read<HistoryBloc>();
    try {
      final picked = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        withData: true,
      );
      final bytes = picked?.files.single.bytes;
      if (bytes == null) return;

      historyBloc.add(
        HistoryEvent.importSavedCodes(
          content: utf8.decode(bytes, allowMalformed: true),
        ),
      );
    } catch (e) {
      if (context.mounted) {
        await DialogUtils.handleFailure(context, l10n.errorImportFailed);
      }
    }
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
          const {
            GenericFlowStep.deletingItem,
            GenericFlowStep.updatingItem,
            GenericFlowStep.exportingItems,
            GenericFlowStep.importingItems,
          }.contains(current.flowStep),
      listener: (context, state) async {
        final historyBloc = context.read<HistoryBloc>();
        void resetFlowStep() =>
            historyBloc.add(const HistoryEvent.resetFlowStep());

        if (state.historyActionStatus == GenericStatus.success) {
          switch (state.flowStep) {
            // A label change shows up in the list itself; no dialog.
            case GenericFlowStep.updatingItem:
              resetFlowStep();
            case GenericFlowStep.exportingItems:
              final path = state.exportFilePath;
              resetFlowStep();
              if (path != null) {
                await Share.shareXFiles(
                  [XFile(path, mimeType: 'application/json')],
                  subject: l10n.exportShareSubject,
                );
              }
            case GenericFlowStep.importingItems:
              final added = state.lastImportAdded ?? 0;
              final skipped = state.lastImportSkipped ?? 0;
              await DialogUtils.handleSuccess(
                context,
                skipped > 0
                    ? '${l10n.msgImportResult(added)} '
                        '${l10n.msgImportSkipped(skipped)}'
                    : l10n.msgImportResult(added),
                postActions: [resetFlowStep],
              );
            default:
              final deletedCount = state.lastDeletedCount;
              await DialogUtils.handleSuccess(
                context,
                deletedCount != null && deletedCount > 1
                    ? l10n.msgCodesDeleted(deletedCount)
                    : l10n.msgCodeDeleted,
                postActions: [resetFlowStep],
              );
          }
        } else if (state.historyActionStatus == GenericStatus.failure) {
          if (context.mounted) {
            await DialogUtils.handleFailure(
              context,
              state.historyActionErrorMessage ?? l10n.operationError,
              postActions: [resetFlowStep],
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
          onShare: () => showShareLocationSheet(
            context,
            ShareableLocation.fromSavedCode(code),
          ),
          onEditLabel: () async {
            final historyBloc = context.read<HistoryBloc>();
            final result = await showLabelSheet(
              context,
              title:
                  code.label == null ? l10n.addLabelTitle : l10n.editLabelTitle,
              plusCode: code.globalCode ?? '',
              initialLabel: code.label,
            );
            if (result != null && code.id != null) {
              historyBloc.add(
                HistoryEvent.updateLabel(id: code.id!, label: result.label),
              );
            }
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
