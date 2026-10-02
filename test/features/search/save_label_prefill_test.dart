import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:plus_locate/plus_locate.dart';

final l10n = lookupAppLocalizations(const Locale('en'));

const _code = '6FMHVGFR+F4';

const _result = SearchState(
  searchStatus: GenericStatus.success,
  plusCode: PlusCode(globalCode: _code, latitude: 3.87, longitude: 11.54),
  locationResult: LocationResult(
    formattedAddress: 'Dovv Essos, Yaoundé, Cameroon',
    locality: 'Yaoundé',
    latitude: 3.87,
    longitude: 11.54,
  ),
);

/// Answers every Places request with a canned JSON body.
class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this._body);

  final Map<String, dynamic> _body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async =>
      ResponseBody.fromString(
        jsonEncode(_body),
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );

  @override
  void close({bool force = false}) {}
}

SearchBloc _searchBloc({PlacesRepository? places}) => SearchBloc(
      plusCodeRepository: PlusCodeRepository(),
      geocodingRepository: GeocodingRepository(),
      quotaRepository: SearchQuotaRepository(),
      placesRepository: places ?? PlacesRepository(),
    );

Future<TextEditingController> _openSaveSheet(
  WidgetTester tester, {
  required SearchState searchState,
  List<SavedCode> saved = const [],
}) async {
  final searchBloc = _searchBloc();
  final historyBloc = HistoryBloc(repository: SavedCodesRepository());
  addTearDown(searchBloc.close);
  addTearDown(historyBloc.close);

  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: searchBloc),
          BlocProvider.value(value: historyBloc),
        ],
        child: const SearchPage(),
      ),
    ),
  );

  // ignore: invalid_use_of_visible_for_testing_member
  historyBloc.emit(HistoryState(savedCodes: saved));
  // ignore: invalid_use_of_visible_for_testing_member
  searchBloc.emit(searchState);
  await tester.pump();

  await tester.tap(find.byTooltip(l10n.actionSave));
  await tester.pumpAndSettle();

  return tester.widget<TextField>(find.byType(TextField).last).controller!;
}

void main() {
  group('saving a search result', () {
    testWidgets('pre-fills the label with the picked place name, selected',
        (tester) async {
      final field = await _openSaveSheet(
        tester,
        searchState: _result.copyWith(placeName: 'Dovv Essos'),
      );

      expect(field.text, 'Dovv Essos');
      expect(field.selection.start, 0);
      expect(field.selection.end, 'Dovv Essos'.length);
    });

    testWidgets('an existing label wins over the place name', (tester) async {
      final field = await _openSaveSheet(
        tester,
        searchState: _result.copyWith(placeName: 'Dovv Essos'),
        saved: const [SavedCode(globalCode: _code, label: 'Shop')],
      );

      expect(field.text, 'Shop');
    });

    testWidgets('a Plus Code search leaves the label empty', (tester) async {
      final field = await _openSaveSheet(tester, searchState: _result);

      expect(field.text, isEmpty);
    });
  });

  group('SearchBloc.placeName', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('place_name_test');
      Hive.init(tempDir.path);
      LocalizationService.setAppLocalizations(l10n);
    });

    tearDown(() async {
      await Hive.deleteFromDisk();
      await tempDir.delete(recursive: true);
    });

    test('is set by a picked suggestion and cleared by the next search',
        () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://places.googleapis.com/v1/'))
        ..httpClientAdapter = _FakeAdapter(const {
          'id': 'p1',
          'formattedAddress': 'Dovv Essos, Yaoundé, Cameroon',
          'location': {'latitude': 3.87, 'longitude': 11.54},
        });
      final bloc = _searchBloc(
        places: PlacesRepository(
          apiProvider: PlacesApiProvider(dio: dio, apiKey: 'k'),
        ),
      );
      addTearDown(bloc.close);

      final picked = expectLater(
        bloc.stream,
        emitsThrough(
          predicate<SearchState>(
            (s) =>
                s.searchStatus == GenericStatus.success &&
                s.placeName == 'Dovv Essos',
          ),
        ),
      );
      bloc.add(
        const SearchEvent.suggestionSelected(
          suggestion: PlaceSuggestion(
            placeId: 'p1',
            mainText: 'Dovv Essos',
            secondaryText: 'Yaoundé, Cameroon',
          ),
        ),
      );
      await picked;

      final searchedCode = expectLater(
        bloc.stream,
        emitsThrough(
          predicate<SearchState>(
            (s) => s.searchStatus == GenericStatus.success,
          ),
        ),
      );
      bloc.add(const SearchEvent.submitQuery(query: _code));
      await searchedCode;

      expect(bloc.state.placeName, isNull);
    });
  });
}
