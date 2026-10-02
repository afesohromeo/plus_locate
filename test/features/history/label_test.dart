import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:plus_locate/plus_locate.dart';

final l10n = lookupAppLocalizations(const Locale('en'));

Widget _host(Widget child) => MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Scaffold(body: child),
    );

/// A button that opens the label sheet and records what it returned.
class _SheetLauncher extends StatelessWidget {
  const _SheetLauncher({required this.onResult, this.initialLabel});

  final ValueChanged<LabelSheetResult?> onResult;
  final String? initialLabel;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async => onResult(
        await showLabelSheet(
          context,
          title: 'Save location',
          plusCode: '6FMHVGFR+F4',
          initialLabel: initialLabel,
        ),
      ),
      child: const Text('open'),
    );
  }
}

SavedLocationCard _card(SavedCode code, {VoidCallback? onEditLabel}) =>
    SavedLocationCard(
      code: code,
      onTap: () {},
      onCopy: () {},
      onShare: () {},
      onDelete: () {},
      onEditLabel: onEditLabel ?? () {},
    );

void main() {
  group('label sheet', () {
    testWidgets('returns the trimmed label on Save', (tester) async {
      LabelSheetResult? result;
      await tester.pumpWidget(
        _host(_SheetLauncher(onResult: (r) => result = r)),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), '  Home ');
      await tester.tap(find.text(l10n.actionSave));
      await tester.pumpAndSettle();

      expect(result?.label, 'Home');
    });

    testWidgets('returns null on Cancel', (tester) async {
      LabelSheetResult? result = (label: 'unchanged');
      await tester.pumpWidget(
        _host(_SheetLauncher(onResult: (r) => result = r)),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text(l10n.cancel));
      await tester.pumpAndSettle();

      expect(result, isNull);
    });

    testWidgets('is pre-filled with the existing label', (tester) async {
      await tester.pumpWidget(
        _host(_SheetLauncher(onResult: (_) {}, initialLabel: 'Shop')),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(TextField, 'Shop'), findsOneWidget);
    });
  });

  group('saved location card', () {
    const code = SavedCode(globalCode: '6FMHVGFR+F4', locality: 'Yaoundé');

    testWidgets('shows the label as its title', (tester) async {
      await tester.pumpWidget(_host(_card(code.copyWith(label: 'Home'))));

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Yaoundé'), findsNothing);
      expect(find.text('6FMHVGFR+F4'), findsOneWidget);
    });

    testWidgets('falls back to the locality without a label', (tester) async {
      await tester.pumpWidget(_host(_card(code)));

      expect(find.text('Yaoundé'), findsOneWidget);
    });

    testWidgets('menu offers Add label, or Edit label when labelled',
        (tester) async {
      var edits = 0;
      await tester.pumpWidget(_host(_card(code, onEditLabel: () => edits++)));
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      await tester.tap(find.text(l10n.addLabelTitle));
      await tester.pumpAndSettle();
      expect(edits, 1);

      await tester.pumpWidget(_host(_card(code.copyWith(label: 'Home'))));
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      expect(find.text(l10n.editLabelTitle), findsOneWidget);
    });
  });

  group('HistoryBloc.updateLabel', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('history_label_test');
      Hive.init(tempDir.path);
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(SavedCodeAdapter());
      }
    });

    tearDown(() async {
      await Hive.deleteFromDisk();
      await tempDir.delete(recursive: true);
    });

    test('labels a saved location and refreshes the list', () async {
      final repository = SavedCodesRepository();
      final saved = (await repository.saveCode(
        const SavedCode(globalCode: '6FMHVGFR+F4'),
      ))!;
      final bloc = HistoryBloc(repository: repository);

      final labelled = expectLater(
        bloc.stream,
        emitsThrough(
          predicate<HistoryState>(
            (s) =>
                s.historyStatus == GenericStatus.success &&
                s.savedCodes.any((c) => c.label == 'Home'),
          ),
        ),
      );
      bloc.add(HistoryEvent.updateLabel(id: saved.id!, label: 'Home'));

      await labelled;
      expect(bloc.state.flowStep, GenericFlowStep.updatingItem);
      await bloc.close();
    });
  });
}
