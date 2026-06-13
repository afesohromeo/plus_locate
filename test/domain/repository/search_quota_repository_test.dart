import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:plus_locate/src/domain/repository/search_quota_repository.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('search_quota_test');
    Hive.init(tempDir.path);
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
    await tempDir.delete(recursive: true);
  });

  group('SearchQuotaRepository', () {
    test('allows autocomplete when under the monthly limit', () async {
      final repository = SearchQuotaRepository();
      expect(await repository.canUseAutocomplete(), isTrue);
    });

    test('blocks autocomplete once the monthly limit is reached', () async {
      final repository = SearchQuotaRepository();

      for (
        var i = 0;
        i < SearchQuotaRepository.maxMonthlyAutocompleteSearches;
        i++
      ) {
        await repository.recordAutocompleteUsage();
      }

      expect(await repository.canUseAutocomplete(), isFalse);
    });
  });
}