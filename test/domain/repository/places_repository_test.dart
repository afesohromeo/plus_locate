import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plus_locate/src/data/api/places/places_api_provider.dart';
import 'package:plus_locate/src/domain/repository/places_repository.dart';

/// Answers every request with a canned JSON body and records the requests.
class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this._respond);

  final (int, Map<String, dynamic>) Function(RequestOptions) _respond;
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final (status, body) = _respond(options);
    return ResponseBody.fromString(
      jsonEncode(body),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

const _autocompleteBody = {
  'suggestions': [
    {
      'placePrediction': {
        'placeId': 'place-1',
        'text': {'text': 'Douala, Cameroon'},
        'structuredFormat': {
          'mainText': {'text': 'Douala'},
          'secondaryText': {'text': 'Cameroon'},
        },
      },
    },
    // Query predictions have no placePrediction and must be skipped.
    {
      'queryPrediction': {
        'text': {'text': 'douala restaurants'},
      },
    },
  ],
};

const _detailsBody = {
  'id': 'place-1',
  'formattedAddress': 'Douala, Cameroon',
  'location': {'latitude': 4.0511, 'longitude': 9.7679},
  'addressComponents': [
    {
      'longText': 'Douala',
      'types': ['locality', 'political'],
    },
    {
      'longText': 'Cameroon',
      'types': ['country', 'political'],
    },
  ],
};

PlacesRepository _repository(_FakeAdapter adapter, {String apiKey = 'k'}) {
  final dio = Dio(BaseOptions(baseUrl: 'https://places.googleapis.com/v1/'))
    ..httpClientAdapter = adapter;
  return PlacesRepository(
    apiProvider: PlacesApiProvider(dio: dio, apiKey: apiKey),
  );
}

void main() {
  group('PlacesRepository', () {
    test('autocomplete maps place predictions and skips the rest', () async {
      final adapter = _FakeAdapter((_) => (200, _autocompleteBody));

      final suggestions =
          await _repository(adapter).autocomplete(input: 'Doua');

      expect(suggestions, hasLength(1));
      expect(suggestions.single.placeId, 'place-1');
      expect(suggestions.single.title, 'Douala');
      expect(suggestions.single.secondaryText, 'Cameroon');
      expect(adapter.requests.single.headers['X-Goog-Api-Key'], 'k');
    });

    test('placeDetails maps address, coordinates, locality and country',
        () async {
      final adapter = _FakeAdapter((_) => (200, _detailsBody));

      final result =
          await _repository(adapter).placeDetails(placeId: 'place-1');

      expect(result?.formattedAddress, 'Douala, Cameroon');
      expect(result?.latitude, 4.0511);
      expect(result?.longitude, 9.7679);
      expect(result?.locality, 'Douala');
      expect(result?.country, 'Cameroon');
      expect(
        adapter.requests.single.headers['X-Goog-FieldMask'],
        contains('location'),
      );
    });

    test('autocomplete and details share a session; details ends it', () async {
      final adapter = _FakeAdapter(
        (options) => options.method == 'POST'
            ? (200, _autocompleteBody)
            : (200, _detailsBody),
      );
      final repository = _repository(adapter);

      await repository.autocomplete(input: 'Dou');
      await repository.autocomplete(input: 'Doua');
      await repository.placeDetails(placeId: 'place-1');
      await repository.autocomplete(input: 'Yaou');

      final firstToken = adapter.requests[0].data['sessionToken'];
      expect(adapter.requests[1].data['sessionToken'], firstToken);
      expect(
        adapter.requests[2].queryParameters['sessionToken'],
        firstToken,
      );
      expect(adapter.requests[3].data['sessionToken'], isNot(firstToken));
    });

    test('rethrows when Google denies the request', () async {
      final adapter = _FakeAdapter(
        (_) => (
          403,
          {
            'error': {'code': 403, 'status': 'PERMISSION_DENIED'},
          },
        ),
      );

      expect(
        _repository(adapter).autocomplete(input: 'Doua'),
        throwsA(isA<DioException>()),
      );
    });

    test('fails fast without calling Google when the key is empty', () async {
      final adapter = _FakeAdapter((_) => (200, _autocompleteBody));

      await expectLater(
        _repository(adapter, apiKey: '').autocomplete(input: 'Doua'),
        throwsA(isA<StateError>()),
      );
      expect(adapter.requests, isEmpty);
    });
  });
}
