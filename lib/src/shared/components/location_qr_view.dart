import 'package:flutter/material.dart';
import 'package:plus_locate/plus_locate.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Full-screen QR code that opens [location] in Maps when scanned.
Future<void> showLocationQrCode(
  BuildContext context,
  ShareableLocation location,
) {
  return showDialog<void>(
    context: context,
    useRootNavigator: true,
    builder: (_) =>
        Dialog.fullscreen(child: LocationQrView(location: location)),
  );
}

class LocationQrView extends StatelessWidget {
  const LocationQrView({super.key, required this.location});

  final ShareableLocation location;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final label = location.label?.trim();
    final address = location.address?.trim();

    final body = Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label != null && label.isNotEmpty) ...[
              Text(
                label,
                textAlign: TextAlign.center,
                style: context.textTheme.displayLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: customColors.black1,
                ),
              ),
              const SizedBox(height: 16),
            ],
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                // Scanners need dark modules on a light background.
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: customColors.black1.withValues(alpha: 0.08),
                ),
              ),
              child: QrImageView(
                data: LocationShare.mapsLink(location).toString(),
                size: 240,
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            if (location.plusCode != null)
              Text(
                location.plusCode!,
                style: context.textTheme.displayLarge?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: customColors.primary,
                  letterSpacing: -0.5,
                ),
              ),
            if (address != null && address.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                address,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: customColors.black1.withValues(alpha: 0.7),
                ),
              ),
            ],
            const SizedBox(height: 20),
            Text(
              l10n.qrScanHint,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.copyWith(
                color: customColors.black1.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        hasAppbar: true,
        appBarBgColor: customColors.primary,
        elevation: 0,
        showBottomNav: false,
        showFloatingButton: false,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.qrCodeTitle,
          style: context.textTheme.displayLarge
              ?.copyWith(color: customColors.surface, fontSize: 18),
        ),
      ),
      mobileBody: body,
    );
  }
}
