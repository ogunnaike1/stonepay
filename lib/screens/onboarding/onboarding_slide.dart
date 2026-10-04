import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import 'onboarding_content.dart';

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({super.key, required this.content});

  final OnboardingContent content;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final illustrationSize = (constraints.maxHeight * 0.43).clamp(
          100.0,
          220.0,
        );
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ExcludeSemantics(
                        child: SizedBox.square(
                          dimension: illustrationSize,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      AppColors.blue.withValues(alpha: 0.4),
                                      AppColors.blue.withValues(alpha: 0),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: illustrationSize * 0.9,
                                height: illustrationSize * 0.9,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.paleBlue.withValues(
                                      alpha: 0.12,
                                    ),
                                  ),
                                ),
                              ),
                              Transform.rotate(
                                angle: -0.12,
                                child: Container(
                                  width: illustrationSize * 0.64,
                                  height: illustrationSize * 0.64,
                                  decoration: BoxDecoration(
                                    borderRadius: AppRadii.large,
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        AppColors.blue,
                                        AppColors.surface,
                                      ],
                                    ),
                                    border: Border.all(
                                      color: AppColors.paleBlue.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.black.withValues(
                                          alpha: 0.15,
                                        ),
                                        blurRadius: 28,
                                        offset: const Offset(0, 16),
                                      ),
                                    ],
                                  ),
                                  child: Transform.rotate(
                                    angle: 0.12,
                                    child: Icon(
                                      content.icon,
                                      size: illustrationSize * 0.3,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        content.eyebrow,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: AppColors.paleBlue,
                              letterSpacing: 3,
                            ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        content.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        content.description,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
