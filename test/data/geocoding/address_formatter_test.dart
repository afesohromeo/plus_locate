import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:plus_locate/src/data/api/geocoding/address_formatter.dart';

/// Yaoundé placemark with the fields every sample shares.
Placemark _p({
  String name = '',
  String street = '',
  String thoroughfare = '',
  String subThoroughfare = '',
  String subLocality = '',
  String locality = 'Yaoundé',
  String administrativeArea = 'Centre Region',
}) =>
    Placemark(
      name: name,
      street: street,
      thoroughfare: thoroughfare,
      subThoroughfare: subThoroughfare,
      subLocality: subLocality,
      locality: locality,
      subAdministrativeArea: 'Mfoundi',
      administrativeArea: administrativeArea,
      country: 'Cameroon',
      isoCountryCode: 'CM',
      postalCode: '',
    );

void main() {
  // Real candidates from an Android device in Yaoundé, nearest first.
  group('AddressFormatter on real Yaoundé samples', () {
    test('landmark glued to a Plus Code (3.88234, 11.536625)', () {
      final result = AddressFormatter.format([
        _p(name: 'VGJP+WMJ', street: 'VGJP+WMJ'),
        _p(name: 'Sodepa', street: 'VGJP+VJC Sodepa'),
        _p(
          name: '1422',
          street: '1422 Rue 1.440',
          thoroughfare: 'Rue 1.440',
          subThoroughfare: '1422',
          administrativeArea: 'Région du Centre',
        ),
        _p(name: 'Route de Ngousso', street: 'Rte de Ngousso'),
      ]);

      expect(result.address, 'Sodepa, Yaoundé, Cameroon');
      expect(result.locality, 'Yaoundé');
    });

    test('junk numeric thoroughfare is skipped (3.88809, 11.53919)', () {
      final result = AddressFormatter.format([
        _p(name: 'VGQQ+5R6', street: 'VGQQ+5R6', thoroughfare: '203023'),
        _p(
          name: '391',
          street: '391 Bd du Cinquantenaire',
          thoroughfare: 'Boulevard du Cinquantenaire',
          subThoroughfare: '391',
        ),
        _p(name: 'Yaoundé V', street: 'Yaoundé V'),
      ]);

      expect(result.address, 'Boulevard du Cinquantenaire, Yaoundé, Cameroon');
    });

    test('neighbourhood is included (3.88517, 11.51962)', () {
      final result = AddressFormatter.format([
        _p(
          name: 'VGP9+3VX',
          street: 'VGP9+3VX',
          subLocality: 'Quartier Manguissa',
        ),
        _p(
          name: 'VGM9+WVM',
          street: 'VGM9+WVM',
          subLocality: 'Quartier Manguissa',
        ),
        _p(
          name: '381',
          street: '381 Rue Albert Ateba Ebe',
          thoroughfare: 'Rue Albert Ateba Ebe',
          subThoroughfare: '381',
          subLocality: 'Quartier Manguissa',
        ),
      ]);

      expect(
        result.address,
        'Rue Albert Ateba Ebe, Quartier Manguissa, Yaoundé, Cameroon',
      );
    });

    test('coded road names are skipped (3.87723, 11.51309)', () {
      final result = AddressFormatter.format([
        _p(name: 'VGG7+P6F', street: 'VGG7+P6F', subLocality: 'Ekoudou'),
        _p(
          name: '50',
          street: '50 Rue CE0001YD2',
          thoroughfare: 'Rue CE0001YD2',
          subThoroughfare: '50',
          subLocality: 'Ekoudou',
        ),
        _p(name: 'VGG7+VRJ', street: 'VGG7+VRJ', subLocality: 'Ekoudou'),
        _p(
          name: 'Rue Simekoa',
          street: 'Rue Simekoa',
          thoroughfare: 'Rue Simekoa',
        ),
      ]);

      expect(result.address, 'Rue Simekoa, Ekoudou, Yaoundé, Cameroon');
    });

    test('Plus Code 6FMHVGFR+F4 (3.8736875, 11.5403125)', () {
      final result = AddressFormatter.format([
        _p(name: 'VGFR+F4M', street: 'VGFR+F4M'),
        _p(name: 'VGFR+84C', street: 'VGFR+84C'),
        _p(
          name: '1383',
          street: '1383 Rue Jean Abanda Bili',
          thoroughfare: 'Rue Jean Abanda Bili',
          subThoroughfare: '1383',
        ),
        _p(name: 'Unnamed Road', street: 'Unnamed Road'),
      ]);

      expect(result.address, 'Rue Jean Abanda Bili, Yaoundé, Cameroon');
    });
  });

  group('AddressFormatter edge cases', () {
    test('only Plus Codes and junk: neighbourhood, city, country', () {
      final result = AddressFormatter.format([
        _p(name: 'VGFR+F4M', street: 'VGFR+F4M', subLocality: 'Essos'),
        _p(name: 'Unnamed Road', street: 'Unnamed Road'),
        _p(name: 'Yaoundé V', street: 'Yaoundé V'),
      ]);

      expect(result.address, 'Essos, Yaoundé, Cameroon');
    });

    test('parts differing only by accents or case are not repeated', () {
      final result = AddressFormatter.format([
        _p(thoroughfare: 'Essos', subLocality: 'ÉSSOS'),
      ]);

      expect(result.address, 'Essos, Yaoundé, Cameroon');
    });

    test('short road numbers like N4 are kept', () {
      final result = AddressFormatter.format([
        _p(name: '381', street: '381 N4', thoroughfare: 'N4'),
      ]);

      expect(result.address, 'N4, Yaoundé, Cameroon');
    });

    test('rural point without locality falls back to wider areas', () {
      final result = AddressFormatter.format([
        Placemark(
          street: '7GQ2+2H',
          subAdministrativeArea: 'Lekié',
          administrativeArea: 'Centre Region',
          country: 'Cameroon',
        ),
      ]);

      expect(result.address, 'Lekié, Centre Region, Cameroon');
      expect(result.locality, 'Lekié');
    });

    test('no candidates gives no address', () {
      final result = AddressFormatter.format(const []);

      expect(result.address, isNull);
      expect(result.locality, isNull);
    });
  });
}
