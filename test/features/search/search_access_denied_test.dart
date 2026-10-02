import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plus_locate/plus_locate.dart';

final l10n = lookupAppLocalizations(const Locale('en'));

/// Answers every Places request with [status] and an error body.
class _FailingAdapter implements HttpClientAdapter {
  _FailingAdapter(this.status);

  final int status;
  var requests = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests++;
    return ResponseBody.fromString(
      jsonEncode({
        'error': {'code': status, 'status': 'ERROR'},
      }),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

SearchBloc _bloc(_FailingAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'https://places.googleapis.com/v1/'))
    ..httpClientAdapter = adapter;
  return SearchBloc(
    plusCodeRepository: PlusCodeRepository(),
    geocodingRepository: GeocodingRepository(),
    quotaRepository: SearchQuotaRepository(),
    placesRepository: PlacesRepository(
      apiProvider: PlacesApiProvider(dio: dio, apiKey: 'k'),
    ),
  );
}

void main() {
  setUp(() => LocalizationService.setAppLocalizations(l10n));

  test('Google refusing the project switches to search-on-submit silently',
      () async {
    final adapter = _FailingAdapter(403);
    final bloc = _bloc(adapter);
    addTearDown(bloc.close);

    final switched = expectLater(
      bloc.stream,
      emitsThrough(
        predicate<SearchState>((s) => s.searchMode == SearchMode.onSubmit),
      ),
    );
    bloc.add(const SearchEvent.queryChanged(query: 'Douala'));
    await switched;

    expect(bloc.state.suggestionsErrorMessage, isNull);
    expect(bloc.state.suggestionsStatus, GenericStatus.initial);

    // Later typing makes no more requests.
    bloc.add(const SearchEvent.queryChanged(query: 'Yaoundé'));
    await Future<void>.delayed(const Duration(milliseconds: 1300));
    expect(adapter.requests, 1);
  });

  test('a temporary server error keeps autocomplete and shows the message',
      () async {
    final bloc = _bloc(_FailingAdapter(500));
    addTearDown(bloc.close);

    final failed = expectLater(
      bloc.stream,
      emitsThrough(
        predicate<SearchState>(
          (s) => s.suggestionsStatus == GenericStatus.failure,
        ),
      ),
    );
    bloc.add(const SearchEvent.queryChanged(query: 'Douala'));
    await failed;

    expect(bloc.state.searchMode, SearchMode.autocomplete);
    expect(bloc.state.suggestionsErrorMessage, l10n.errorPlacesUnavailable);
  });
}
