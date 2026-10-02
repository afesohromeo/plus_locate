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

  /// Opens WhatsApp (app if installed, otherwise WhatsApp Web) with
  /// [message] ready to send to any contact.
  static Uri whatsAppUri(String message) =>
      Uri.parse('https://wa.me/?text=${Uri.encodeComponent(message)}');
}
