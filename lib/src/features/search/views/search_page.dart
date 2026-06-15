// lib/src/features/search/views/search_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:plus_locate/plus_locate.dart';
import 'package:share_plus/share_plus.dart';
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
        showDrawer: false,
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

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    context
        .read<SearchBloc>()
        .add(SearchEvent.submitQuery(query: _textController.text));
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
              if (state.searchMode == SearchMode.autocomplete)
                _AutocompleteField(textController: _textController)
              else
                _SubmitField(
                  textController: _textController,
                  onSubmit: () => _submit(context),
                ),
              const SizedBox(height: 16),
              Expanded(child: _buildContent(context, state, l10n)),
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
        return LoadingWidget(loadingText: l10n.loading);
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

/// Live Places Autocomplete field — used while under the monthly quota.
class _AutocompleteField extends StatelessWidget {
  final TextEditingController textController;

  const _AutocompleteField({required this.textController});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GooglePlaceAutoCompleteTextField(
      textEditingController: textController,
      googleAPIKey: Environment.googleMapsApiKey,
      debounceTime: 2000,
      isLatLngRequired: true,
      inputDecoration: InputDecoration(
        hintText: l10n.searchPlacesOrCodes,
        filled: true,
        fillColor: customColors.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      itemClick: (prediction) {
        textController.text = prediction.description ?? '';
        textController.selection = TextSelection.fromPosition(
          TextPosition(offset: textController.text.length),
        );
      },
      getPlaceDetailWithLatLng: (prediction) {
        final latitude = double.tryParse(prediction.lat ?? '');
        final longitude = double.tryParse(prediction.lng ?? '');
        if (latitude == null || longitude == null) return;

        context.read<SearchBloc>().add(
              SearchEvent.placeSelected(
                description: prediction.description ?? '',
                latitude: latitude,
                longitude: longitude,
              ),
            );
      },
    );
  }
}

/// Free-text field + search button — used once the monthly autocomplete
/// quota is exhausted. Auto-detects Plus Code vs. address on submit.
class _SubmitField extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onSubmit;

  const _SubmitField({
    required this.textController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return InputField(
      controller: textController,
      validator: (_) => null,
      labelText: l10n.searchPlacesOrCodes,
      bgColor: customColors.surface,
      borderRadius: BorderRadius.circular(10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      onEditingComplete: onSubmit,
      suffixIcon: IconButton(
        icon: Icon(Icons.search, color: customColors.primary),
        onPressed: onSubmit,
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
          context
              .read<HistoryBloc>()
              .add(HistoryEvent.saveCode(code: savedCode));
        },
        onSharePressed: () {
          final plusCodeVal = state.plusCode?.globalCode ?? '---';
          final latVal = state.latitude?.toStringAsFixed(6) ?? '---';
          final lngVal = state.longitude?.toStringAsFixed(6) ?? '---';
          final addressVal = state.locationResult?.formattedAddress ?? '---';

          Share.share(
            l10n.shareLocationText(plusCodeVal, latVal, lngVal, addressVal),
          );
        },
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
