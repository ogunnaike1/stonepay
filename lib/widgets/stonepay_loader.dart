import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radii.dart';

/// An indeterminate pulse that passes between three small cut-stone shapes.
class StonePayLoader extends StatefulWidget {
  const StonePayLoader({super.key});

  @override
  State<StonePayLoader> createState() => _StonePayLoaderState();
}

class _StonePayLoaderState extends State<StonePayLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  );
  bool _reducedMotion = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reducedMotion = MediaQuery.disableAnimationsOf(context);
    if (_reducedMotion) {
      _controller.stop();
      _controller.value = 0;
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Loading StonePay',
      child: ExcludeSemantics(
        child: RepaintBoundary(
          child: SizedBox(
            width: 88,
            height: 32,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(3, (index) {
                    final phase =
                        (_controller.value - index * 0.18) * 2 * math.pi;
                    final pulse = _reducedMotion
                        ? 0.45
                        : math.pow((math.cos(phase) + 1) / 2, 3).toDouble();
                    return Transform.translate(
                      offset: Offset(0, -4 * pulse),
                      child: Transform.rotate(
                        angle: math.pi / 4,
                        child: Transform.scale(
                          scale: 0.8 + 0.25 * pulse,
                          child: Container(
                            width: 11,
                            height: 11,
                            decoration: BoxDecoration(
                              borderRadius: AppRadii.small / 4,
                              color: Color.lerp(
                                AppColors.blue,
                                AppColors.paleBlue,
                                pulse,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.paleBlue.withValues(
                                    alpha: 0.2 * pulse,
                                  ),
                                  blurRadius: 10 * pulse,
                                  spreadRadius: pulse,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
