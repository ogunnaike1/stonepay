import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/app_button.dart';
import '../../widgets/stonepay_logo.dart';
import 'onboarding_content.dart';
import 'onboarding_slide.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, this.onGetStarted});

  /// Connect this to account setup when that screen is implemented.
  final VoidCallback? onGetStarted;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _page = 0;
  bool _moving = false;
  bool _completing = false;

  bool get _isLast => _page == OnboardingContent.slides.length - 1;

  Future<void> _goTo(int page) async {
    if (_moving) return;
    setState(() => _moving = true);
    if (MediaQuery.disableAnimationsOf(context)) {
      _pageController.jumpToPage(page);
    } else {
      await _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    }
    if (mounted) setState(() => _moving = false);
  }

  Future<void> _getStarted() async {
    if (_completing) return;
    if (widget.onGetStarted != null) {
      widget.onGetStarted!();
      return;
    }
    setState(() => _completing = true);
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Welcome to StonePay'),
        content: const Text('Move. Save. Spend. Smarter.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
    if (mounted) setState(() => _completing = false);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reducedMotion = MediaQuery.disableAnimationsOf(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.background,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.backgroundHighlight, AppColors.background],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: Row(
                    children: [
                      const StonePayLogo(size: 32),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          'StonePay',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      if (!_isLast)
                        AppButton(
                          label: 'Skip',
                          variant: AppButtonVariant.text,
                          expand: false,
                          onPressed: _moving ? null : () => _goTo(2),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: OnboardingContent.slides.length,
                    onPageChanged: (page) => setState(() => _page = page),
                    itemBuilder: (context, index) => OnboardingSlide(
                      content: OnboardingContent.slides[index],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 440),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Semantics(
                            label: 'Slide ${_page + 1} of 3',
                            liveRegion: true,
                            child: ExcludeSemantics(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  3,
                                  (index) => AnimatedContainer(
                                    duration: reducedMotion
                                        ? Duration.zero
                                        : const Duration(milliseconds: 250),
                                    width: index == _page ? 28 : 8,
                                    height: 8,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.xs,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: AppRadii.pill,
                                      color: index == _page
                                          ? AppColors.paleBlue
                                          : AppColors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          AppButton(
                            label: _isLast ? 'Get Started' : 'Next',
                            icon: _isLast ? null : Icons.arrow_forward_rounded,
                            onPressed: _moving || _completing
                                ? null
                                : _isLast
                                ? _getStarted
                                : () => _goTo(_page + 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
