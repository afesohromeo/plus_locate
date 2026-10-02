import 'package:flutter_test/flutter_test.dart';
import 'package:plus_locate/src/domain/repository/plus_code_repository.dart';

void main() {
  group('PlusCodeRepository.isValidPlusCode', () {
    final repository = PlusCodeRepository();

    test('returns true for a valid full Plus Code', () {
      expect(repository.isValidPlusCode('8FVC9G8F+6W'), isTrue);
    });

    test('returns false for an address string', () {
      expect(repository.isValidPlusCode('123 Main Street'), isFalse);
    });

    test('returns false for an empty string', () {
      expect(repository.isValidPlusCode(''), isFalse);
    });
  });

  group('PlusCodeRepository full/short detection', () {
    final repository = PlusCodeRepository();

    test('a global code is full, not short', () {
      expect(repository.isFullPlusCode('8FVC9G8F+6W'), isTrue);
      expect(repository.isShortPlusCode('8FVC9G8F+6W'), isFalse);
    });

    test('a local code is short, not full', () {
      expect(repository.isShortPlusCode('9G8F+6W'), isTrue);
      expect(repository.isFullPlusCode('9G8F+6W'), isFalse);
    });

    test('an address is neither', () {
      expect(repository.isFullPlusCode('Douala'), isFalse);
      expect(repository.isShortPlusCode('Douala'), isFalse);
    });
  });

  group('PlusCodeRepository local code', () {
    final repository = PlusCodeRepository();

    test('encoding fills the short code, not a copy of the global one',
        () async {
      final center = await repository.decodePlusCode(code: '8FVC9G8F+6W');
      final plusCode = await repository.encodePlusCode(
        latitude: center!.latitude!,
        longitude: center.longitude!,
      );

      expect(plusCode?.globalCode, '8FVC9G8F+6W');
      expect(plusCode?.localCode, '9G8F+6W');
    });

    test('decoding fills the short code too', () async {
      final plusCode = await repository.decodePlusCode(code: '6FMHVGFR+F4');

      expect(plusCode?.localCode, 'VGFR+F4');
    });

    test('a padded code has no short form', () async {
      final plusCode = await repository.decodePlusCode(code: '6FMH0000+');

      expect(plusCode?.localCode, isNull);
    });
  });

  group('PlusCodeRepository.recoverShortPlusCode', () {
    final repository = PlusCodeRepository();

    test('recovers the full code nearest to the reference point', () async {
      // Reference point in central Zurich.
      final plusCode = await repository.recoverShortPlusCode(
        shortCode: '9G8F+6W',
        referenceLatitude: 47.3769,
        referenceLongitude: 8.5417,
      );

      expect(plusCode?.globalCode, '8FVC9G8F+6W');
      expect(plusCode?.latitude, closeTo(47.3656, 0.001));
      expect(plusCode?.longitude, closeTo(8.5250, 0.001));
    });
  });
}
