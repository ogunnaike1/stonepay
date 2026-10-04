import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'routing/app_router.dart';
import 'routing/app_routes.dart';

class StonePayApp extends StatelessWidget {
  const StonePayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StonePay',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
      onUnknownRoute: AppRouter.onUnknownRoute,
    );
  }
}
