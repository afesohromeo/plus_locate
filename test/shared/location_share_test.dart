import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plus_locate/plus_locate.dart';
import 'package:qr_flutter/qr_flutter.dart';

final l10n = lookupAppLocalizations(const Locale('en'));

const _location = ShareableLocation(
  plusCode: '6FMHVGFR+F4',
  latitude: 3.8736875,
  longitude: 11.5403125,
  address: 'Rue Jean Abanda Bili, Yaoundé, Cameroon',
  label: 'Home',
);

void main() {
  group('LocationShare', () {
    test('Maps link searches the Plus Code with "+" encoded', () {
      expect(
        LocationShare.mapsLink(_location).toString(),
        'https://www.google.com/maps/search/?api=1&query=6FMHVGFR%2BF4',
      );
    });

    test('Maps link falls back to coordinates without a Plus Code', () {
      const location = ShareableLocation(latitude: 3.87, longitude: 11.54);

      expect(
        LocationShare.mapsLink(location).queryParameters['query'],
        '3.87,11.54',
      );
    });

    test('message: label, Plus Code, address, then the link', () {
      expect(
        LocationShare.message(l10n, _location).split('\n'),
        [
          'Home',
          'Plus Code: 6FMHVGFR+F4',
          'Rue Jean Abanda Bili, Yaoundé, Cameroon',
          'Open in Maps: '
              'https://www.google.com/maps/search/?api=1&query=6FMHVGFR%2BF4',
        ],
      );
    });

    test('message skips a missing label and address', () {
      const location = ShareableLocation(plusCode: '6FMHVGFR+F4', label: ' ');

      expect(
        LocationShare.message(l10n, location).split('\n'),
        [
          'Plus Code: 6FMHVGFR+F4',
          'Open in Maps: '
              'https://www.google.com/maps/search/?api=1&query=6FMHVGFR%2BF4',
        ],
      );
    });

    test('WhatsApp link carries the full message', () {
      final message = LocationShare.message(l10n, _location);
      final uri = LocationShare.whatsAppUri(message);

      expect(uri.host, 'wa.me');
      expect(uri.queryParameters['text'], message);
    });
  });

  group('share sheet', () {
    Future<void> openSheet(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () => showShareLocationSheet(context, _location),
                child: const Text('share'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('share'));
      await tester.pumpAndSettle();
    }

    testWidgets('offers WhatsApp, more apps and QR code', (tester) async {
      await openSheet(tester);

      expect(find.text(l10n.shareViaWhatsApp), findsOneWidget);
      expect(find.text(l10n.shareMoreApps), findsOneWidget);
      expect(find.text(l10n.showQrCode), findsOneWidget);
    });

    testWidgets('QR code option shows a code that opens the Maps link',
        (tester) async {
      await openSheet(tester);

      await tester.tap(find.text(l10n.showQrCode));
      await tester.pumpAndSettle();

      final qr = tester.widget<QrImageView>(find.byType(QrImageView));
      expect(qr, isNotNull);
      expect(find.text(l10n.qrCodeTitle), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('6FMHVGFR+F4'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
