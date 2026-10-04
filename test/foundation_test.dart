import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stonepay/core/routing/app_router.dart';
import 'package:stonepay/core/routing/app_routes.dart';
import 'package:stonepay/theme/app_theme.dart';
import 'package:stonepay/widgets/app_button.dart';
import 'package:stonepay/widgets/app_input_field.dart';

Widget host(Widget child) => MaterialApp(
  theme: AppTheme.dark,
  home: Scaffold(
    body: Padding(padding: const EdgeInsets.all(24), child: child),
  ),
);

void main() {
  for (final variant in AppButtonVariant.values) {
    testWidgets('$variant invokes callback and blocks loading taps', (
      tester,
    ) async {
      var presses = 0;
      await tester.pumpWidget(
        host(
          AppButton(
            label: 'Continue',
            variant: variant,
            onPressed: () => presses++,
          ),
        ),
      );
      await tester.tap(find.text('Continue'));
      expect(presses, 1);

      await tester.pumpWidget(
        host(
          AppButton(
            label: 'Continue',
            variant: variant,
            isLoading: true,
            onPressed: () => presses++,
          ),
        ),
      );
      await tester.tap(find.text('Continue'));
      expect(presses, 1);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpWidget(
        host(AppButton(label: 'Continue', variant: variant, onPressed: null)),
      );
      await tester.tap(find.text('Continue'));
      expect(presses, 1);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  }

  testWidgets('Input validates, updates controller, and submits', (
    tester,
  ) async {
    final form = GlobalKey<FormState>();
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    String? submitted;
    await tester.pumpWidget(
      host(
        Form(
          key: form,
          child: AppInputField(
            label: 'Email address',
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: (value) => value == null || value.isEmpty
                ? 'Enter your email address'
                : null,
            onSubmitted: (value) => submitted = value,
          ),
        ),
      ),
    );
    expect(form.currentState!.validate(), isFalse);
    await tester.pump();
    expect(find.text('Enter your email address'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'test@example.com');
    expect(controller.text, 'test@example.com');
    expect(form.currentState!.validate(), isTrue);
    await tester.pump();
    expect(find.text('Enter your email address'), findsNothing);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    expect(submitted, 'test@example.com');
  });

  testWidgets('Password input masks content and disables suggestions', (
    tester,
  ) async {
    await tester.pumpWidget(
      host(const AppInputField(label: 'Password', obscureText: true)),
    );
    await tester.enterText(find.byType(TextFormField), 'secret');
    final editable = tester.widget<EditableText>(find.byType(EditableText));
    expect(editable.obscureText, isTrue);
    expect(editable.autocorrect, isFalse);
    expect(editable.enableSuggestions, isFalse);
  });

  test('Router resolves splash and falls back for unknown paths', () {
    final splash = AppRouter.onGenerateRoute(
      const RouteSettings(name: AppRoutes.splash),
    );
    expect(splash, isA<MaterialPageRoute<void>>());
    expect(splash!.settings.name, AppRoutes.splash);
    const unknown = RouteSettings(name: '/missing');
    expect(AppRouter.onGenerateRoute(unknown), isNull);
    expect(AppRouter.onUnknownRoute(unknown).settings.name, AppRoutes.splash);
  });
}
