# StonePay

Flutter fintech app foundation with a blue dark theme based on the supplied palette:
black `#000000`, white `#FFFFFF`, pale blue `#BACAE2`, blue `#3760B2`, and
deep blue `#00126B`. Tonal blue blends provide surface depth; pale blue keeps
secondary text and outlined actions readable on dark backgrounds.
The app includes the splash and a three-slide onboarding flow.

## Structure

```text
lib/
  main.dart                 App entry point
  core/
    stonepay_app.dart        MaterialApp configuration
    routing/
      app_routes.dart       Named route constants
      app_router.dart       Route generation and unknown-route fallback
  theme/
    app_colors.dart         Brand and semantic colors
    app_text_styles.dart    Typography
    app_spacing.dart        Spacing scale
    app_radii.dart          Border radii
    app_theme.dart          Material theme and control defaults
  screens/splash/            Responsive splash screen
  screens/onboarding/
    onboarding_content.dart Move, save, and spend slide copy
    onboarding_slide.dart   Responsive illustration and text layout
    onboarding_screen.dart  Paging, indicators, and actions
  widgets/
    app_button.dart         Primary, secondary, and text actions
    app_input_field.dart    Form-compatible text input
    fade_in.dart            Reduced-motion-aware fade animation
    stonepay_logo.dart      Vector sculpted ribbon S monogram
    stonepay_loader.dart    Looping three-stone loading pulse
```

## Reusable controls

```dart
AppButton(
  label: 'Continue',
  onPressed: () {},
  variant: AppButtonVariant.primary,
  isLoading: false,
);

AppInputField(
  label: 'Email address',
  controller: emailController,
  keyboardType: TextInputType.emailAddress,
  textInputAction: TextInputAction.next,
  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
);
```

Buttons default to full width within a bounded parent. Set `expand: false` for
inline actions. A null callback or `isLoading: true` disables taps. Loading
retains the label and adds a progress indicator and accessibility status.

Inputs inherit theme decoration and support validation inside a `Form`, external
errors, helper text, icons, formatters, autofill, focus, and submission callbacks.
Set `obscureText: true` for password entry. The calling screen owns and disposes
any supplied controller and focus node.

## Routing

The app starts at `AppRoutes.splash` (`/`) and replaces it with
`AppRoutes.onboarding` (`/onboarding`) after three seconds. Unknown route names
fall back to the splash. Define future route names in `app_routes.dart` and
resolve them in `AppRouter.onGenerateRoute`.

The splash includes an indeterminate three-stone pulse that respects reduced
motion. It is a visual loading indicator; no startup service or progress
tracking is connected yet.

Onboarding supports swiping, Next, and Skip (jumps to the final slide). Get
Started invokes the optional `onGetStarted` callback; without a destination,
it shows a welcome dialog. Login, account creation, and persistent onboarding
completion are not implemented. Onboarding appears on every launch for now.

## Run and verify

```sh
flutter run
flutter analyze
flutter test
```
