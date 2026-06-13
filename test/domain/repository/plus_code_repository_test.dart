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
}
