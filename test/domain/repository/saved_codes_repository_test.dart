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

  group('SavedCodesRepository export/import', () {
    test('round-trips labels, addresses and dates', () async {
      final original = await repository.saveCode(code.copyWith(
        label: 'Home',
        address: 'Rue Jean Abanda Bili, Yaoundé, Cameroon',
        latitude: 3.8736875,
        longitude: 11.5403125,
      ));
      await repository.saveCode(
        const SavedCode(globalCode: '6FMHVGJP+WM', locality: 'Yaoundé'),
      );
      final json = await repository.exportJson();

      // Simulate a new phone: wipe everything, then import the file.
      await Hive.deleteFromDisk();
      final result = await SavedCodesRepository().importJson(json);

      expect(result, (added: 2, skipped: 0));
      final restored = await SavedCodesRepository().fetchAllSavedCodes();
      final home = restored.firstWhere((c) => c.globalCode == '6FMHVGFR+F4');
      expect(home.label, 'Home');
      expect(home.address, 'Rue Jean Abanda Bili, Yaoundé, Cameroon');
      expect(home.latitude, 3.8736875);
      expect(home.savedAt, original!.savedAt);
    });

    test('importing the same file twice adds nothing the second time',
        () async {
      await repository.saveCode(code);
      final json = await repository.exportJson();

      expect(await repository.importJson(json), (added: 0, skipped: 1));
      expect(await repository.fetchAllSavedCodes(), hasLength(1));
    });

    test('rejects files that are not PlusLocate exports', () async {
      for (final content in [
        'not json at all',
        '[]',
        '{"format": "something.else", "locations": []}',
        '{"format": "pluslocate.saved_locations"}',
      ]) {
        await expectLater(
          repository.importJson(content),
          throwsA(isA<FormatException>()),
          reason: content,
        );
      }
    });

    test('exports only the selected ids when given', () async {
      final home = (await repository.saveCode(code.copyWith(label: 'Home')))!;
      await repository.saveCode(const SavedCode(globalCode: '6FMHVG88+MM'));

      final json = await repository.exportJson(ids: {home.id!});

      await Hive.deleteFromDisk();
      final result = await SavedCodesRepository().importJson(json);
      expect(result, (added: 1, skipped: 0));
      final restored = await SavedCodesRepository().fetchAllSavedCodes();
      expect(restored.single.label, 'Home');
    });

    test('skips entries without a Plus Code', () async {
      final result = await repository.importJson('''
        {"format": "pluslocate.saved_locations", "version": 1,
         "locations": [{"label": "No code"}, 42,
                       {"global_code": "6FMHVGFR+F4"}]}''');

      expect(result, (added: 1, skipped: 2));
    });
  });
}
