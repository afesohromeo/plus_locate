import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_locate/plus_locate.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  bool _loading = false;

  Future<void> _onGetStarted() async {
    if (_loading) return;
    setState(() => _loading = true);
    await SecureStorageHelper.markOnboardingSeen();
    if (mounted) context.goNamed(mapViewRouteName);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        hasAppbar: false,
        showBottomNav: false,
        showFloatingButton: false,
        showDrawer: false,
        bgColor: customColors.background,
      ),
      mobileBody: _OnboardingBody(
        loading: _loading,
        onGetStarted: _onGetStarted,
        l10n: l10n,
      ),
    );
  }
}

class _OnboardingBody extends StatelessWidget {
  const _OnboardingBody({
    required this.loading,
    required this.onGetStarted,
    required this.l10n,
  });

  final bool loading;
  final VoidCallback onGetStarted;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          _buildLogo(context),
          const SizedBox(height: 48),
          _buildHero(context),
          const SizedBox(height: 36),
          _buildPlusCodeCard(context),
          const SizedBox(height: 32),
          _buildHeadline(context),
          const SizedBox(height: 32),
          _buildFeaturePills(context),
          const SizedBox(height: 48),
          _buildGetStartedButton(context),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, color: customColors.primary, size: 28),
        const SizedBox(width: 6),
        Text(
          l10n.appTitle,
          style: context.textTheme.titleLarge?.copyWith(
            color: customColors.primary,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildHero(BuildContext context) {
    return Center(
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          color: customColors.primary.withValues(alpha: 0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.location_on,
          size: 100,
          color: customColors.primary,
        ),
      ),
    );
  }

  Widget _buildPlusCodeCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: customColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: customColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '8FVC9G8F+W2',
            style: context.textTheme.headlineSmall?.copyWith(
              color: customColors.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.verified, size: 16, color: customColors.primary),
              const SizedBox(width: 4),
              Text(
                l10n.onboardingPrecise,
                style: context.textTheme.bodySmall?.copyWith(
                  color: customColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.onboardingHeadline,
          style: context.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w800,
            height: 1.15,
            color: customColors.black1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          l10n.onboardingTagline,
          style: context.textTheme.bodyLarge?.copyWith(
            color: customColors.black1.withValues(alpha: 0.6),
            height: 1.55,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturePills(BuildContext context) {
    final features = [
      (Icons.public, l10n.onboardingFeatureGlobal),
      (Icons.offline_pin_outlined, l10n.onboardingFeatureOffline),
      (Icons.share_outlined, l10n.onboardingFeatureShare),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final (icon, label) in features)
          _FeaturePill(icon: icon, label: label, context: context),
      ],
    );
  }

  Widget _FeaturePill({
    required BuildContext context,
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: customColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: customColors.primary.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: customColors.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: customColors.black1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return PrimaryButton(
      height: 52,
      width: double.infinity,
      onPressed: loading ? null : onGetStarted,
      child: loading
          ? SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: customColors.surface,
              ),
            )
          : Text(
              l10n.getStarted,
              style: context.textTheme.labelLarge?.copyWith(
                color: customColors.surface,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
    );
  }
}
