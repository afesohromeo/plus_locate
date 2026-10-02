import 'package:flutter/material.dart';
import 'package:plus_locate/plus_locate.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Share options for [location]: WhatsApp, other apps, or a QR code.
Future<void> showShareLocationSheet(
  BuildContext context,
  ShareableLocation location,
) {
  final l10n = AppLocalizations.of(context)!;
  final message = LocationShare.message(l10n, location);

  return showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    backgroundColor: customColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) => ShareLocationSheet(
      onWhatsApp: () {
        Navigator.of(sheetContext).pop();
        _shareViaWhatsApp(message);
      },
      onMoreApps: () {
        Navigator.of(sheetContext).pop();
        Share.share(message);
      },
      onQrCode: () {
        Navigator.of(sheetContext).pop();
        if (context.mounted) showLocationQrCode(context, location);
      },
    ),
  );
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
    required this.onQrCode,
  });

  final VoidCallback onWhatsApp;
  final VoidCallback onMoreApps;
  final VoidCallback onQrCode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    Widget option(IconData icon, String label, VoidCallback onTap) => ListTile(
          onTap: onTap,
          leading: Icon(icon, color: customColors.primary),
          title: Text(
            label,
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: customColors.black1,
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
            option(Icons.qr_code_2, l10n.showQrCode, onQrCode),
          ],
        ),
      ),
    );
  }
}
