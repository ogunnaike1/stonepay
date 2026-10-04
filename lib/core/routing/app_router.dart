import 'package:flutter/material.dart';

import '../../screens/splash/splash_screen.dart';
import '../../screens/onboarding/onboarding_screen.dart';
import 'app_routes.dart';

abstract final class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => SplashScreen(
            onFinished: () =>
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.onboarding),
          ),
        );
      case AppRoutes.onboarding:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const OnboardingScreen(),
        );
      default:
        return null;
    }
  }

  /// Until more screens exist, unknown routes safely return to the splash.
  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return onGenerateRoute(const RouteSettings(name: AppRoutes.splash))!;
  }
}
