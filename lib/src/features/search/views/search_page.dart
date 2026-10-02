// lib/src/features/search/views/search_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_locate/plus_locate.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        hasAppbar: true,
        appBarBgColor: customColors.primary,
        elevation: 0,
        showBottomNav: false,
        showFloatingButton: false,
        resizeToAvoidBottomInset: true,
        leading: const Icon(Icons.search_rounded, color: Colors.white),
        title: Text(
          l10n.search,
          style: context.textTheme.displayLarge
              ?.copyWith(color: customColors.surface, fontSize: 18),
        ),
      ),
      mobileBody: const _SearchBody(),
      tabletBody: const _SearchBody(),
      desktopBody: const _SearchBody(),
    );
  }
}

class _SearchBody extends StatefulWidget {
  const _SearchBody();

  @override
  State<_SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<_SearchBody> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    _focusNode.unfocus();
    context
        .read<SearchBloc>()
        .add(SearchEvent.submitQuery(query: _textController.text));
  }

  void _selectSuggestion(PlaceSuggestion suggestion) {
    _focusNode.unfocus();
    _textController.text = suggestion.fullText ?? suggestion.title;
    _textController.selection = TextSelection.collapsed(
      offset: _textController.text.length,
    );
    context
        .read<SearchBloc>()
        .add(SearchEvent.suggestionSelected(suggestion: suggestion));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SearchField(
                textController: _textController,
                focusNode: _focusNode,
                onSubmit: _submit,
              ),
              if (state.suggestionsStatus == GenericStatus.failure &&
                  state.suggestionsErrorMessage != null)
                _SuggestionsError(message: state.suggestionsErrorMessage!),
              const SizedBox(height: 16),
              Expanded(
                // While refreshing, existing suggestions stay on screen until
                // the new ones arrive; placeholders only fill an empty list.
                child: state.suggestions.isNotEmpty
                    ? _SuggestionList(
                        suggestions: state.suggestions,
                        onSelected: _selectSuggestion,
                      )
                    : state.suggestionsStatus == GenericStatus.loading
                        ? const _SuggestionListSkeleton()
                        : _buildContent(context, state, l10n),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    SearchState state,
    AppLocalizations l10n,
  ) {
    switch (state.searchStatus) {
      case GenericStatus.loading:
        return const SingleChildScrollView(
          child: PlusCodeDetailCardSkeleton.card(margin: EdgeInsets.zero),
        );
      case GenericStatus.failure:
        return ErrorrWidget(
          errorMessage: state.searchErrorMessage ?? l10n.operationError,
          refreshText: l10n.refresh,
          onPressed: () =>
              context.read<SearchBloc>().add(const SearchEvent.reset()),
        );
      case GenericStatus.success:
        return _SearchResultView(state: state);
      default:
        return EmptyWidget(
          emptyText: l10n.searchInitialPrompt,
          onPressed: () =>
              context.read<SearchBloc>().add(const SearchEvent.reset()),
        );
    }
  }
}

/// Search text field. Typing feeds autocomplete (the bloc ignores it in
/// on-submit mode); the keyboard action or search button always submits.
class _SearchField extends StatelessWidget {
  final TextEditingController textController;
  final FocusNode focusNode;
  final VoidCallback onSubmit;

  const _SearchField({
    required this.textController,
    required this.focusNode,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SearchInputField(
      inputController: textController,
      focusNode: focusNode,
      labelText: l10n.searchPlacesOrCodes,
      bgColor: customColors.surface,
      labelColor: customColors.black1.withValues(alpha: .7),
      onChanged: (query) => context
          .read<SearchBloc>()
          .add(SearchEvent.queryChanged(query: query)),
      onEditingComplete: onSubmit,
      onSuffixPressed: onSubmit,
    );
  }
}

/// Shown under the field when suggestions can't be loaded. Submitting still
/// works through the device geocoder.
class _SuggestionsError extends StatelessWidget {
  final String message;

  const _SuggestionsError({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 16, color: customColors.error),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              message,
              style: context.textTheme.bodySmall?.copyWith(
                color: customColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Placeholder rows shaped like [_SuggestionList] items.
class _SuggestionListSkeleton extends StatelessWidget {
  const _SuggestionListSkeleton();

  static const _rowCount = 3;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Semantics(
        label: AppLocalizations.of(context)!.loading,
        child: Material(
          color: customColors.surface,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ShimmerSkeleton(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < _rowCount; i++)
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          SkeletonBox.circle(size: 24),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SkeletonBox(width: 160, height: 14),
                                SizedBox(height: 6),
                                SkeletonBox(width: 100, height: 12),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SuggestionList extends StatelessWidget {
  final List<PlaceSuggestion> suggestions;
  final ValueChanged<PlaceSuggestion> onSelected;

  const _SuggestionList({
    required this.suggestions,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // A Material (not a decorated Container) so the ListTile ink ripples
    // paint on this background instead of behind it.
    return Material(
      color: customColors.surface,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 4),
        // Last row is the Google attribution required by the Places policy.
        itemCount: suggestions.length + 1,
        separatorBuilder: (_, __) => Divider(
          height: 1,
          color: customColors.black1.withValues(alpha: 0.08),
        ),
        itemBuilder: (context, index) {
          if (index == suggestions.length) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                l10n.poweredByGoogle,
                textAlign: TextAlign.end,
                style: context.textTheme.labelSmall?.copyWith(
                  color: customColors.black1.withValues(alpha: 0.5),
                ),
              ),
            );
          }

          final suggestion = suggestions[index];
          return ListTile(
            onTap: () => onSelected(suggestion),
            leading: Icon(Icons.place_outlined, color: customColors.primary),
            title: Text(
              suggestion.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: customColors.black1,
              ),
            ),
            subtitle: suggestion.secondaryText == null
                ? null
                : Text(
                    suggestion.secondaryText!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: customColors.black1.withValues(alpha: 0.6),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class _SearchResultView extends StatelessWidget {
  final SearchState state;

  const _SearchResultView({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: PlusCodeDetailCard(
        margin: EdgeInsets.zero,
        title: l10n.searchResult,
        locationResult: state.locationResult,
        plusCode: state.plusCode,
        status: state.searchStatus,
        onNavigatePressed: () async {
          final latitude = state.latitude;
          final longitude = state.longitude;
          if (latitude == null || longitude == null) return;

          final url = Uri.parse(
            'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude',
          );
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          } else if (context.mounted) {
            await DialogUtils.handleFailure(context, l10n.operationError);
          }
        },
        onSavePressed: () {
          if (state.plusCode == null) return;

          final savedCode = SavedCode(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            globalCode: state.plusCode?.globalCode,
            localCode: state.plusCode?.localCode,
            latitude: state.latitude,
            longitude: state.longitude,
            locality: state.locationResult?.locality,
            address: state.locationResult?.formattedAddress,
            savedAt: DateTime.now(),
          );
          saveLocationWithLabel(
            context,
            savedCode,
            suggestedLabel: state.placeName,
          );
        },
        onSharePressed: () => showShareLocationSheet(
          context,
          ShareableLocation(
            plusCode: state.plusCode?.globalCode,
            latitude: state.latitude,
            longitude: state.longitude,
            address: state.locationResult?.formattedAddress,
            label: state.placeName,
          ),
        ),
        onCopyPlusCode: () async {
          final code = state.plusCode?.globalCode;
          if (code == null) return;

          Clipboard.setData(ClipboardData(text: code));
          if (context.mounted) {
            await DialogUtils.handleSuccess(context, l10n.msgCodeCopied);
          }
        },
        onViewOnMapPressed: () {
          final latitude = state.latitude;
          final longitude = state.longitude;
          if (latitude == null || longitude == null) return;

          context.read<MapViewBloc>().add(
                MapViewEvent.focusOnLocation(
                  latitude: latitude,
                  longitude: longitude,
                  plusCode: state.plusCode,
                  locationResult: state.locationResult,
                ),
              );
          context.goNamed(mapViewRouteName);
        },
      ),
    );
  }
}
