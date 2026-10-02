import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:plus_locate/src/domain/models/saved_code.dart';
import 'package:plus_locate/src/domain/repository/saved_codes_repository.dart';

void main() {
  late Directory tempDir;
  late SavedCodesRepository repository;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('saved_codes_test');
    Hive.init(tempDir.path);
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(SavedCodeAdapter());
    repository = SavedCodesRepository();
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
    await tempDir.delete(recursive: true);
  });

  const code = SavedCode(globalCode: '6FMHVGFR+F4', locality: 'Yaoundé');

  group('SavedCodesRepository labels', () {
    test('re-saving without a label keeps the existing label', () async {
      await repository.saveCode(code.copyWith(label: 'Home'));
      await repository.saveCode(code);

      final saved = await repository.fetchAllSavedCodes();
      expect(saved, hasLength(1));
      expect(saved.single.label, 'Home');
    });

    test('re-saving with a blank label removes it', () async {
      await repository.saveCode(code.copyWith(label: 'Home'));
      await repository.saveCode(code.copyWith(label: '   '));

      final saved = await repository.fetchAllSavedCodes();
      expect(saved.single.label, isNull);
    });

    test('updateLabel sets a trimmed label and clears a blank one', () async {
      final saved = (await repository.saveCode(code))!;

      final labelled =
          await repository.updateLabel(id: saved.id!, label: '  Shop ');
      expect(labelled?.label, 'Shop');

      final cleared = await repository.updateLabel(id: saved.id!, label: '');
      expect(cleared?.label, isNull);
      expect((await repository.fetchAllSavedCodes()).single.label, isNull);
    });

    test('updateLabel returns null for an unknown id', () async {
      expect(await repository.updateLabel(id: 'missing', label: 'x'), isNull);
    });
  });
}
