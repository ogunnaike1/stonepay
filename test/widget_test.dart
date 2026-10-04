import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stonepay/screens/splash/splash_screen.dart';
import 'package:stonepay/theme/app_theme.dart';
import 'package:stonepay/widgets/fade_in.dart';
import 'package:stonepay/widgets/stonepay_logo.dart';
import 'package:stonepay/widgets/stonepay_loader.dart';

void main() {
  testWidgets('Splash shows the brand and fades in', (tester) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.dark, home: const SplashScreen()),
    );
    final fade = find.descendant(
      of: find.byType(FadeIn),
      matching: find.byType(FadeTransition),
    );
    expect(tester.widget<FadeTransition>(fade).opacity.value, 0);
    await tester.pump(const Duration(milliseconds: 450));
    final halfwayOpacity = tester.widget<FadeTransition>(fade).opacity.value;
    expect(halfwayOpacity, greaterThan(0));
    expect(halfwayOpacity, lessThan(1));
    await tester.pump(const Duration(milliseconds: 500));

    expect(tester.widget<FadeTransition>(fade).opacity.value, 1);
    expect(find.byType(StonePayLogo), findsOneWidget);
    expect(find.text('StonePay'), findsOneWidget);
    expect(find.text('Move. Save. Spend. Smarter.'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsNothing);
  });

  for (final size in [
    const Size(320, 568),
    const Size(390, 844),
    const Size(430, 932),
    const Size(568, 320),
  ]) {
    testWidgets('Splash fits $size with large text', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpWidget(
        MaterialApp(theme: AppTheme.dark, home: const SplashScreen()),
      );
      expect(
        MediaQuery.textScalerOf(tester.element(find.text('StonePay')))
            .scale(16),
        32,
      );
      await tester.pump(const Duration(seconds: 1));
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.text('Move. Save. Spend. Smarter.'));
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Reduced motion shows splash immediately', (tester) async {
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.dark, home: const SplashScreen()),
    );
    final fade = find.descendant(
      of: find.byType(FadeIn),
      matching: find.byType(FadeTransition),
    );
    expect(tester.widget<FadeTransition>(fade).opacity.value, 1);
    await tester.pump();
    expect(tester.binding.hasScheduledFrame, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Loading pulse loops and disposes cleanly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.dark, home: const SplashScreen()),
    );
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(StonePayLoader), findsOneWidget);
    expect(find.bySemanticsLabel('Loading StonePay'), findsOneWidget);
    expect(tester.binding.hasScheduledFrame, isTrue);
    await tester.pump(const Duration(seconds: 4));
    expect(tester.binding.hasScheduledFrame, isTrue);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    expect(tester.binding.hasScheduledFrame, isFalse);
    expect(tester.takeException(), isNull);
  });
}
