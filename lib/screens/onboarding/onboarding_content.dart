import 'package:flutter/material.dart';

class OnboardingContent {
  const OnboardingContent({
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String eyebrow;
  final String title;
  final String description;
  final IconData icon;

  static const slides = [
    OnboardingContent(
      eyebrow: 'MOVE',
      title: 'Money in motion.',
      description:
          'A simpler way to send and receive money. '
          'Keep life moving with StonePay.',
      icon: Icons.swap_horiz_rounded,
    ),
    OnboardingContent(
      eyebrow: 'SAVE',
      title: 'Small steps. Big plans.',
      description:
          'Make room for what matters. '
          'Build better saving habits, one goal at a time.',
      icon: Icons.savings_outlined,
    ),
    OnboardingContent(
      eyebrow: 'SPEND',
      title: 'Your money. Your rhythm.',
      description:
          'Bring clarity to everyday spending. '
          'Move. Save. Spend. Smarter.',
      icon: Icons.credit_card_rounded,
    ),
  ];
}
