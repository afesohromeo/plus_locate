import 'package:geocoding/geocoding.dart';

/// Builds a readable address from the device geocoder's candidates.
///
/// The device geocoder (Android in particular) returns several placemarks,
/// nearest first. In areas without formal addressing the nearest one is often
/// just a Plus Code, while later ones carry the useful parts: a named street,
/// a landmark ("VGJP+VJC Sodepa"), or the neighbourhood. This picks the first
/// meaningful street/landmark across all candidates, drops Plus Codes, house
/// numbers and generated road names, and removes repeated parts.
class AddressFormatter {
  AddressFormatter._();

  static final _plusCodeToken = RegExp(
    r'^[02-9CFGHJMPQRVWX]{2,8}\+[2-9CFGHJMPQRVWX]*$',
    caseSensitive: false,
  );
  static final _leadingHouseNumber = RegExp(r'^\d+[A-Za-z]?\s+');

  /// Formatted address plus the city, for [placemarks] ordered nearest first.
  static ({String? address, String? locality, String? country}) format(
    List<Placemark> placemarks,
  ) {
    String? firstOf(String? Function(Placemark p) field) => placemarks
        .map(field)
        .map((value) => value?.trim())
        .firstWhere((value) => value != null && value.isNotEmpty,
            orElse: () => null);

    final locality = firstOf((p) => p.locality);
    final subLocality = firstOf((p) => p.subLocality);
    final country = firstOf((p) => p.country);
    final street = _nearestMeaningfulStreet(placemarks, locality);

    final parts = <String>[];
    final seen = <String>{};
    void add(String? part) {
      if (part == null || part.isEmpty) return;
      if (seen.add(_normalize(part))) parts.add(part);
    }

    add(street);
    add(subLocality);
    if (locality != null) {
      add(locality);
    } else {
      // Rural areas often have no locality; fall back to the wider areas.
      add(firstOf((p) => p.subAdministrativeArea));
      add(firstOf((p) => p.administrativeArea));
    }
    add(country);

    return (
      address: parts.isEmpty ? null : parts.join(', '),
      locality: locality ?? firstOf((p) => p.subAdministrativeArea),
      country: country,
    );
  }

  static String? _nearestMeaningfulStreet(
    List<Placemark> placemarks,
    String? locality,
  ) {
    for (final placemark in placemarks) {
      // Prefer the unabbreviated thoroughfare ("Boulevard" over "Bd"); fall
      // back to the street line, which is where landmark names appear.
      for (final candidate in [placemark.thoroughfare, placemark.street]) {
        final cleaned = _cleanStreet(candidate);
        if (cleaned != null && _isMeaningful(cleaned, locality)) {
          return cleaned;
        }
      }
    }
    return null;
  }

  /// Removes Plus Code words and a leading house number (it belongs to a
  /// nearby parcel, not to the selected point).
  static String? _cleanStreet(String? value) {
    if (value == null) return null;
    final words = value
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => !_plusCodeToken.hasMatch(word));
    final cleaned =
        words.join(' ').replaceFirst(_leadingHouseNumber, '').trim();
    return cleaned.isEmpty ? null : cleaned;
  }

  static bool _isMeaningful(String street, String? locality) {
    final normalized = _normalize(street);
    if (normalized == 'unnamed road' || normalized == 'route sans nom') {
      return false;
    }
    // A district of the city ("Yaoundé V") repeats the locality.
    if (locality != null && normalized.startsWith(_normalize(locality))) {
      return false;
    }
    for (final word in street.split(RegExp(r'\s+'))) {
      final hasDigit = word.contains(RegExp(r'\d'));
      if (!hasDigit) continue;
      // Generated names: "Rue 1.440", "Rue CE0001YD2", a bare "203023".
      // Short road numbers such as "N4" stay.
      if (RegExp(r'^\d+(\.\d+)+$').hasMatch(word)) return false;
      if (word.length >= 5) return false;
    }
    return true;
  }

  /// Lowercase without common Latin diacritics, so "Yaounde" == "Yaoundé".
  static String _normalize(String value) {
    const from = 'àáâãäåçèéêëìíîïñòóôõöùúûüýÿ';
    const to = 'aaaaaaceeeeiiiinooooouuuuyy';
    final buffer = StringBuffer();
    for (final char in value.toLowerCase().split('')) {
      final index = from.indexOf(char);
      buffer.write(index == -1 ? char : to[index]);
    }
    return buffer.toString().trim();
  }
}
