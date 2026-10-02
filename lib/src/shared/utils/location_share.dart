import 'package:plus_locate/plus_locate.dart';

/// What gets shared about a location.
class ShareableLocation {
  const ShareableLocation({
    this.plusCode,
    this.latitude,
    this.longitude,
    this.address,
    this.label,
  });

  /// A saved location, with its address falling back to the locality.
  factory ShareableLocation.fromSavedCode(SavedCode code) => ShareableLocation(
        plusCode: code.globalCode,
        latitude: code.latitude,
        longitude: code.longitude,
        address: code.address ?? code.locality,
        label: code.label,
      );

  final String? plusCode;
  final double? latitude;
  final double? longitude;
  final String? address;

  /// User label or place name, used as the message's first line.
  final String? label;
}

/// Builds share messages and links for a [ShareableLocation].
class LocationShare {
  LocationShare._();

  /// Google Maps link; opens the Maps app on most phones. Uses the Plus Code
  /// when there is one (Maps shows it), otherwise the coordinates.
  static Uri mapsLink(ShareableLocation location) {
    final query =
        location.plusCode ?? '${location.latitude},${location.longitude}';
    return Uri.parse(
      'https://www.google.com/maps/search/?api=1'
      '&query=${Uri.encodeComponent(query)}',
    );
  }

  /// Multi-line message: label, Plus Code, address, Maps link.
  static String message(AppLocalizations l10n, ShareableLocation location) {
    final label = location.label?.trim();
    final address = location.address?.trim();
    return [
      if (label != null && label.isNotEmpty) label,
      if (location.plusCode != null) l10n.sharePlusCodeLine(location.plusCode!),
      if (address != null && address.isNotEmpty) address,
      l10n.shareOpenInMapsLine(mapsLink(location).toString()),
    ].join('\n');
  }

  /// One message for several locations: a header, then each location's
  /// [message], numbered. A single location gets the plain [message].
  static String messageForMany(
    AppLocalizations l10n,
    List<ShareableLocation> locations,
  ) {
    if (locations.length == 1) return message(l10n, locations.single);
    return [
      l10n.shareManyHeader(locations.length),
      for (var i = 0; i < locations.length; i++)
        '${i + 1}. ${message(l10n, locations[i])}',
    ].join('\n\n');
  }

  /// Opens WhatsApp (app if installed, otherwise WhatsApp Web) with
  /// [message] ready to send to any contact.
  static Uri whatsAppUri(String message) =>
      Uri.parse('https://wa.me/?text=${Uri.encodeComponent(message)}');
}
