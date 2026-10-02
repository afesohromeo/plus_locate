import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plus_locate/plus_locate.dart';

final l10n = lookupAppLocalizations(const Locale('en'));

const _address = 'Rue Joss, Douala';
const _code = '6FR5+2X';

Widget _host(Widget card) => MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Scaffold(body: SingleChildScrollView(child: card)),
    );

PlusCodeDetailCard _card({
  bool expanded = true,
  ValueChanged<bool>? onExpandedChanged,
}) =>
    PlusCodeDetailCard(
      locationResult: const LocationResult(
        formattedAddress: _address,
        latitude: 4.05,
        longitude: 9.76,
        locality: 'Douala',
      ),
      plusCode: const PlusCode(
        globalCode: _code,
        latitude: 4.05,
        longitude: 9.76,
      ),
      status: GenericStatus.success,
      onNavigatePressed: () {},
      onSavePressed: () {},
      onSharePressed: () {},
      onCopyPlusCode: () {},
      expanded: expanded,
      onExpandedChanged: onExpandedChanged,
    );

void main() {
  group('PlusCodeDetailCard', () {
    testWidgets('collapsed shows the summary only', (tester) async {
      await tester.pumpWidget(
        _host(_card(expanded: false, onExpandedChanged: (_) {})),
      );

      expect(find.text('Douala'), findsOneWidget);
      expect(find.text(_code), findsOneWidget);
      expect(find.byTooltip(l10n.navigate), findsOneWidget);
      expect(find.text(_address), findsNothing);
      expect(find.text(l10n.labelLatitude), findsNothing);
      expect(find.byTooltip(l10n.actionSave), findsNothing);
    });

    testWidgets('expanded shows the full details', (tester) async {
      await tester.pumpWidget(
        _host(_card(expanded: true, onExpandedChanged: (_) {})),
      );

      expect(find.text(_address), findsOneWidget);
      expect(find.text(l10n.labelLatitude), findsOneWidget);
      expect(find.byTooltip(l10n.actionSave), findsOneWidget);
    });

    testWidgets('without a callback it always shows full details',
        (tester) async {
      await tester.pumpWidget(_host(_card(expanded: false)));

      expect(find.text(_address), findsOneWidget);
      expect(find.byTooltip(l10n.actionSave), findsOneWidget);
      expect(find.bySemanticsLabel(l10n.showDetails), findsNothing);
    });

    testWidgets('tapping the handle asks to expand', (tester) async {
      bool? requested;
      await tester.pumpWidget(
        _host(_card(expanded: false, onExpandedChanged: (v) => requested = v)),
      );

      await tester.tap(find.bySemanticsLabel(l10n.showDetails));
      expect(requested, isTrue);
    });

    testWidgets('flicking down asks to collapse', (tester) async {
      bool? requested;
      await tester.pumpWidget(
        _host(_card(expanded: true, onExpandedChanged: (v) => requested = v)),
      );

      await tester.fling(find.text(_address), const Offset(0, 200), 1000);
      expect(requested, isFalse);
    });

    // Search-tab configuration: four actions, no margin, French labels
    // (the longest), at common narrow phone widths.
    for (final width in [320.0, 360.0, 393.0]) {
      testWidgets('search card fits a $width px wide screen', (tester) async {
        tester.view.physicalSize = Size(width * 3, 800 * 3);
        tester.view.devicePixelRatio = 3;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('fr'),
            home: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: PlusCodeDetailCard(
                    margin: EdgeInsets.zero,
                    title: 'Résultat de recherche',
                    locationResult: const LocationResult(
                      formattedAddress: _address,
                      locality: 'Douala',
                      latitude: 4.05,
                      longitude: 9.76,
                    ),
                    plusCode: const PlusCode(globalCode: '6FR52QXV+2X'),
                    status: GenericStatus.success,
                    onNavigatePressed: () {},
                    onSavePressed: () {},
                    onSharePressed: () {},
                    onCopyPlusCode: () {},
                    onViewOnMapPressed: () {},
                  ),
                ),
              ),
            ),
          ),
        );

        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('loading shows the skeleton matching the card state',
        (tester) async {
      PlusCodeDetailCard loadingCard({required bool expanded}) =>
          PlusCodeDetailCard(
            status: GenericStatus.loading,
            onNavigatePressed: () {},
            onSavePressed: () {},
            onSharePressed: () {},
            onCopyPlusCode: () {},
            expanded: expanded,
            onExpandedChanged: (_) {},
          );

      await tester.pumpWidget(_host(loadingCard(expanded: false)));
      expect(
        tester
            .widget<PlusCodeDetailCardSkeleton>(
              find.byType(PlusCodeDetailCardSkeleton),
            )
            .compact,
        isTrue,
      );
      expect(find.byType(CircularProgressIndicator), findsNothing);

      await tester.pumpWidget(_host(loadingCard(expanded: true)));
      expect(
        tester
            .widget<PlusCodeDetailCardSkeleton>(
              find.byType(PlusCodeDetailCardSkeleton),
            )
            .compact,
        isFalse,
      );
    });
  });
}
