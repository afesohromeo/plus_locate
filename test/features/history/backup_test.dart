import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:plus_locate/plus_locate.dart';

final l10n = lookupAppLocalizations(const Locale('en'));

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('backup_test');
    Hive.init(tempDir.path);
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(SavedCodeAdapter());
    LocalizationService.setAppLocalizations(l10n);
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
    await tempDir.delete(recursive: true);
  });

  group('HistoryBloc.importSavedCodes', () {
    test('reports added/skipped counts and refreshes the list', () async {
      final repository = SavedCodesRepository();
      await repository.saveCode(const SavedCode(globalCode: '6FMHVGFR+F4'));
      final bloc = HistoryBloc(repository: repository);
      addTearDown(bloc.close);

      final imported = expectLater(
        bloc.stream,
        emitsThrough(
          predicate<HistoryState>(
            (s) =>
                s.historyStatus == GenericStatus.success &&
                s.savedCodes.length == 2,
          ),
        ),
      );
      bloc.add(const HistoryEvent.importSavedCodes(content: '''
        {"format": "pluslocate.saved_locations", "version": 1,
         "locations": [{"global_code": "6FMHVGFR+F4"},
                       {"global_code": "6FMHVGJP+WM", "label": "Shop"}]}'''));
      await imported;

      expect(bloc.state.lastImportAdded, 1);
      expect(bloc.state.lastImportSkipped, 1);
      expect(bloc.state.flowStep, GenericFlowStep.importingItems);
    });

    test('an invalid file reports the dedicated error', () async {
      final bloc = HistoryBloc(repository: SavedCodesRepository());
      addTearDown(bloc.close);

      final failed = expectLater(
        bloc.stream,
        emitsThrough(
          predicate<HistoryState>(
            (s) => s.historyActionStatus == GenericStatus.failure,
          ),
        ),
      );
      bloc.add(const HistoryEvent.importSavedCodes(content: '{"hello": 1}'));
      await failed;

      expect(bloc.state.historyActionErrorMessage, l10n.errorImportInvalidFile);
    });
  });

  group('Saved tab menu', () {
    Future<void> openMenu(WidgetTester tester, List<SavedCode> saved) async {
      final bloc = HistoryBloc(repository: SavedCodesRepository());
      addTearDown(bloc.close);

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: BlocProvider.value(value: bloc, child: const HistoryPage()),
        ),
      );
      // ignore: invalid_use_of_visible_for_testing_member
      bloc.emit(HistoryState(
        historyStatus: GenericStatus.success,
        savedCodes: saved,
      ));
      await tester.pump();

      // Saved cards have their own menus; open the one in the app bar.
      await tester.tap(find.descendant(
        of: find.byType(AppBar),
        matching: find.byType(PopupMenuButton<String>),
      ));
      await tester.pumpAndSettle();
    }

    PopupMenuItem<String> item(WidgetTester tester, String text) =>
        tester.widget<PopupMenuItem<String>>(
          find.ancestor(
            of: find.text(text),
            matching: find.byType(PopupMenuItem<String>),
          ),
        );

    testWidgets('offers Import, and Export only when there is something',
        (tester) async {
      await openMenu(tester, const []);

      expect(item(tester, l10n.actionImport).enabled, isTrue);
      expect(item(tester, l10n.actionExport).enabled, isFalse);
    });

    testWidgets('Export is enabled once locations are saved', (tester) async {
      await openMenu(tester, const [SavedCode(globalCode: '6FMHVGFR+F4')]);

      expect(item(tester, l10n.actionExport).enabled, isTrue);
    });
  });
}
