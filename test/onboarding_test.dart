import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stonepay/core/stonepay_app.dart';
import 'package:stonepay/screens/onboarding/onboarding_screen.dart';
import 'package:stonepay/screens/splash/splash_screen.dart';
import 'package:stonepay/theme/app_theme.dart';

Widget host() =>
    MaterialApp(theme: AppTheme.dark, home: const OnboardingScreen());

void main() {
  testWidgets('Next advances through three slides and Get Started completes', (
    tester,
  ) async {
    await tester.pumpWidget(host());
    expect(find.text('Money in motion.'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Small steps. Big plans.'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Your money. Your rhythm.'), findsOneWidget);
    expect(find.text('Skip'), findsNothing);
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome to StonePay'), findsOneWidget);
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('Skip goes to final slide and swipe returns to previous slide', (
    tester,
  ) async {
    await tester.pumpWidget(host());
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.text('Get Started'), findsOneWidget);
    await tester.drag(find.byType(PageView), const Offset(600, 0));
    await tester.pumpAndSettle();
    expect(find.text('Small steps. Big plans.'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('Splash opens onboarding and is removed from back stack', (
    tester,
  ) async {
    await tester.pumpWidget(const StonePayApp());
    expect(find.byType(SplashScreen), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.byType(SplashScreen), findsNothing);
    expect(
      Navigator.of(tester.element(find.byType(OnboardingScreen))).canPop(),
      isFalse,
    );
  });

  for (final size in [const Size(320, 568), const Size(568, 320)]) {
    testWidgets('Onboarding fits $size with enlarged text', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpWidget(host());
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();
      expect(find.text('Get Started').hitTestable(), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Reduced motion skips page animation and calls completion', (
    tester,
  ) async {
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    var completed = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: OnboardingScreen(onGetStarted: () => completed = true),
      ),
    );
    await tester.tap(find.text('Skip'));
    await tester.pump();
    expect(find.text('Get Started'), findsOneWidget);
    await tester.tap(find.text('Get Started'));
    expect(completed, isTrue);
  });
}
