import 'package:flutter/material.dart';
import 'package:plus_locate/plus_locate.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Share options for [location]: WhatsApp, other apps, or a QR code.
Future<void> showShareLocationSheet(
  BuildContext context,
  ShareableLocation location,
) =>
    showShareLocationsSheet(context, [location]);

/// Share options for [locations]: WhatsApp and other apps send one message
/// listing them all. The QR code is offered only for a single location;
/// [onShareAsFile], when given, adds a "PlusLocate file" option.
///
/// Returns whether the user picked an option (false if dismissed).
Future<bool> showShareLocationsSheet(
  BuildContext context,
  List<ShareableLocation> locations, {
  VoidCallback? onShareAsFile,
}) async {
  final l10n = AppLocalizations.of(context)!;
  final message = LocationShare.messageForMany(l10n, locations);

  final chosen = await showModalBottomSheet<bool>(
    context: context,
    useRootNavigator: true,
    backgroundColor: customColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      void choose(VoidCallback action) {
        Navigator.of(sheetContext).pop(true);
        action();
      }

      return ShareLocationSheet(
        onWhatsApp: () => choose(() => _shareViaWhatsApp(message)),
        onMoreApps: () => choose(() => Share.share(message)),
        onQrCode: locations.length == 1
            ? () => choose(() {
                  if (context.mounted) {
                    showLocationQrCode(context, locations.single);
                  }
                })
            : null,
        onShareAsFile:
            onShareAsFile == null ? null : () => choose(onShareAsFile),
      );
    },
  );
  return chosen ?? false;
}

/// Falls back to the system share sheet when WhatsApp can't be opened.
Future<void> _shareViaWhatsApp(String message) async {
  var launched = false;
  try {
    launched = await launchUrl(
      LocationShare.whatsAppUri(message),
      mode: LaunchMode.externalApplication,
    );
  } catch (_) {}
  if (!launched) await Share.share(message);
}

class ShareLocationSheet extends StatelessWidget {
  const ShareLocationSheet({
    super.key,
    required this.onWhatsApp,
    required this.onMoreApps,
    this.onQrCode,
    this.onShareAsFile,
  });

  final VoidCallback onWhatsApp;
  final VoidCallback onMoreApps;

  /// Hidden when null.
  final VoidCallback? onQrCode;

  /// Hidden when null.
  final VoidCallback? onShareAsFile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    Widget option(
      IconData icon,
      String label,
      VoidCallback onTap, {
      String? subtitle,
    }) =>
        ListTile(
          onTap: onTap,
          leading: Icon(icon, color: customColors.primary),
          title: Text(
            label,
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: customColors.black1,
            ),
          ),
          subtitle: subtitle == null
              ? null
              : Text(
                  subtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: customColors.black1.withValues(alpha: 0.6),
                  ),
                ),
        );

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                l10n.shareSheetTitle,
                style: context.textTheme.displayLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: customColors.black1,
                ),
              ),
            ),
            option(Icons.chat_outlined, l10n.shareViaWhatsApp, onWhatsApp),
            option(Icons.share_outlined, l10n.shareMoreApps, onMoreApps),
            if (onQrCode != null)
              option(Icons.qr_code_2, l10n.showQrCode, onQrCode!),
            if (onShareAsFile != null)
              option(
                Icons.file_present_outlined,
                l10n.shareAsPlusLocateFile,
                onShareAsFile!,
                subtitle: l10n.shareAsPlusLocateFileHint,
              ),
          ],
        ),
      ),
    );
  }
}
