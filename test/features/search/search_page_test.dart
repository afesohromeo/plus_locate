import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plus_locate/plus_locate.dart';

SearchBloc _searchBloc() => SearchBloc(
      plusCodeRepository: PlusCodeRepository(),
      geocodingRepository: GeocodingRepository(),
      quotaRepository: SearchQuotaRepository(),
      placesRepository: PlacesRepository(),
    );

Widget _host(SearchBloc bloc) => MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: BlocProvider.value(value: bloc, child: const SearchPage()),
    );

void main() {
  testWidgets('search field uses neutral colors, not the error color',
      (tester) async {
    final bloc = _searchBloc();
    addTearDown(bloc.close);
    await tester.pumpWidget(_host(bloc));

    final decoration =
        tester.widget<TextField>(find.byType(TextField)).decoration!;
    final border = decoration.enabledBorder! as OutlineInputBorder;

    expect(border.borderSide.color, isNot(customColors.error));
    expect(
      border.borderSide.color,
      isNot(customColors.error.withValues(alpha: .5)),
    );
    expect(decoration.labelStyle?.color, isNot(customColors.error));
  });

  testWidgets('a running search shows the skeleton card', (tester) async {
    final bloc = _searchBloc();
    addTearDown(bloc.close);
    await tester.pumpWidget(_host(bloc));

    // ignore: invalid_use_of_visible_for_testing_member
    bloc.emit(const SearchState(searchStatus: GenericStatus.loading));
    // The shimmer repeats forever, so pump a frame instead of settling.
    await tester.pump();

    expect(find.byType(PlusCodeDetailCardSkeleton), findsOneWidget);
    expect(find.byType(LoadingWidget), findsNothing);
  });

  testWidgets('suggestion list renders without framework errors',
      (tester) async {
    final bloc = _searchBloc();
    addTearDown(bloc.close);
    await tester.pumpWidget(_host(bloc));

    // ignore: invalid_use_of_visible_for_testing_member
    bloc.emit(
      const SearchState(
        suggestionsStatus: GenericStatus.success,
        suggestions: [
          PlaceSuggestion(
            placeId: 'p1',
            mainText: 'Douala',
            secondaryText: 'Cameroon',
          ),
        ],
      ),
    );
    await tester.pump();

    expect(find.text('Douala'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  group('while suggestions load', () {
    final l10n = lookupAppLocalizations(const Locale('en'));

    testWidgets('an empty list shows placeholder rows, not a progress bar',
        (tester) async {
      final bloc = _searchBloc();
      addTearDown(bloc.close);
      await tester.pumpWidget(_host(bloc));

      // ignore: invalid_use_of_visible_for_testing_member
      bloc.emit(const SearchState(suggestionsStatus: GenericStatus.loading));
      await tester.pump();

      expect(find.bySemanticsLabel(l10n.loading), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsNothing);
    });

    testWidgets('existing suggestions stay visible during a refresh',
        (tester) async {
      final bloc = _searchBloc();
      addTearDown(bloc.close);
      await tester.pumpWidget(_host(bloc));

      // ignore: invalid_use_of_visible_for_testing_member
      bloc.emit(
        const SearchState(
          suggestionsStatus: GenericStatus.loading,
          suggestions: [PlaceSuggestion(placeId: 'p1', mainText: 'Douala')],
        ),
      );
      await tester.pump();

      expect(find.text('Douala'), findsOneWidget);
      expect(find.bySemanticsLabel(l10n.loading), findsNothing);
    });
  });
}
