import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_locate/plus_locate.dart';

const _kHeroGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF0288D1)],
);

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
      mobileBody: LayoutBuilder(
        builder: (context, constraints) {
          return _OnboardingBody(
            loading: _loading,
            onGetStarted: _onGetStarted,
            l10n: l10n,
            availableHeight: constraints.maxHeight,
          );
        },
      ),
    );
  }
}

class _OnboardingBody extends StatelessWidget {
  const _OnboardingBody({
    required this.loading,
    required this.onGetStarted,
    required this.l10n,
    required this.availableHeight,
  });

  final bool loading;
  final VoidCallback onGetStarted;
  final AppLocalizations l10n;
  final double availableHeight;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final heroHeight = availableHeight * 0.52;

    return Column(
      children: [
        _HeroPanel(
          l10n: l10n,
          height: heroHeight,
          topPadding: topPadding,
        ),
        Expanded(
          child: _ContentPanel(
            l10n: l10n,
            loading: loading,
            onGetStarted: onGetStarted,
            bottomPadding: bottomPadding,
          ),
        ),
      ],
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({
    required this.l10n,
    required this.height,
    required this.topPadding,
  });

  final AppLocalizations l10n;
  final double height;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
        gradient: _kHeroGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, topPadding + 16, 24, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LogoRow(l10n: l10n),
            const Spacer(),
            Center(
              child: Image.asset(
                'assets/images/PlusLocate_3.png',
                height: height * 0.38,
                fit: BoxFit.contain,
              ),
            ),
            const Spacer(),
            _PlusCodeBadge(l10n: l10n),
          ],
        ),
      ),
    );
  }
}

class _LogoRow extends StatelessWidget {
  const _LogoRow({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/PlusLocate_3.png',
          height: 28,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 8),
        Text(
          l10n.appTitle,
          style: context.textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}

class _PlusCodeBadge extends StatelessWidget {
  const _PlusCodeBadge({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '8FVC9G8F+W2',
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.2,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.verified_rounded,
                      size: 15,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      l10n.onboardingPrecise,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(
            Icons.my_location_rounded,
            color: Colors.white,
            size: 22,
          ),
        ],
      ),
    );
  }
}

class _ContentPanel extends StatelessWidget {
  const _ContentPanel({
    required this.l10n,
    required this.loading,
    required this.onGetStarted,
    required this.bottomPadding,
  });

  final AppLocalizations l10n;
  final bool loading;
  final VoidCallback onGetStarted;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 28),
          Text.rich(
            TextSpan(
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                height: 1.2,
                color: customColors.black1,
              ),
              children: [
                TextSpan(text: '${l10n.onboardingHeadline}\n'),
                TextSpan(
                  text: l10n.onboardingHeadlineAccent,
                  style: TextStyle(color: customColors.primary),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            l10n.onboardingTagline,
            style: context.textTheme.bodyLarge?.copyWith(
              color: customColors.black1,
              height: 1.55,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          _FeaturePills(l10n: l10n),
          const SizedBox(height: 20),
          _GetStartedButton(
              loading: loading, onGetStarted: onGetStarted, l10n: l10n),
          SizedBox(height: 20 + bottomPadding),
        ],
      ),
    );
  }
}

class _FeaturePills extends StatelessWidget {
  const _FeaturePills({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final features = [
      (Icons.public_rounded, l10n.onboardingFeatureGlobal),
      (Icons.offline_pin_rounded, l10n.onboardingFeatureOffline),
      (Icons.share_rounded, l10n.onboardingFeatureShare),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        for (final (icon, label) in features) _Pill(icon: icon, label: label),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: customColors.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: customColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: customColors.primary),
          const SizedBox(width: 5),
          Text(
            label,
            style: context.textTheme.displaySmall?.copyWith(
              color: customColors.black1,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _GetStartedButton extends StatelessWidget {
  const _GetStartedButton({
    required this.loading,
    required this.onGetStarted,
    required this.l10n,
  });

  final bool loading;
  final VoidCallback onGetStarted;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
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
              style: context.textTheme.displayLarge?.copyWith(
                color: customColors.surface,
                fontSize: 16,
              ),
            ),
    );
  }
}
