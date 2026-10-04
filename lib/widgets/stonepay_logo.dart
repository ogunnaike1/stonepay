import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// A sculpted ribbon S monogram drawn as a vector for crisp rendering at any size.
class StonePayLogo extends StatelessWidget {
  const StonePayLogo({super.key, this.size = 96}) : assert(size > 0);

  final double size;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.backgroundHighlight, AppColors.background],
          ),
          border: Border.all(color: AppColors.paleBlue.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(
              color: AppColors.logo.withValues(alpha: 0.06),
              blurRadius: size * 0.4,
              spreadRadius: size * 0.04,
            ),
          ],
        ),
        child: SizedBox.square(
          dimension: size * 0.72,
          child: CustomPaint(painter: _StonePayMarkPainter()),
        ),
      ),
    );
  }
}

class _StonePayMarkPainter extends CustomPainter {
  _StonePayMarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width, size.height);

    // Mirrored curves form a continuous ribbon, with open space around the
    // middle so the mark stays legible at small sizes.
    final ribbon = Path()
      ..moveTo(0.73, 0.25)
      ..cubicTo(0.62, 0.12, 0.36, 0.12, 0.27, 0.27)
      ..cubicTo(0.14, 0.49, 0.40, 0.47, 0.50, 0.50)
      ..cubicTo(0.60, 0.53, 0.86, 0.51, 0.73, 0.73)
      ..cubicTo(0.64, 0.88, 0.38, 0.88, 0.27, 0.75);

    final highlight = Color.lerp(AppColors.logo, AppColors.primaryText, 0.32)!;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.145
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [highlight, AppColors.logo, AppColors.logo],
        stops: const [0, 0.55, 1],
      ).createShader(const Rect.fromLTWH(0, 0, 1, 1));
    canvas.drawPath(ribbon, paint);
    canvas.restore();
  }

  @override
  // Repaint when Flutter updates this widget, including after hot reload.
  bool shouldRepaint(covariant _StonePayMarkPainter oldDelegate) => true;
}
