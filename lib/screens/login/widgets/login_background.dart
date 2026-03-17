import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class LoginBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = AppTheme.primaryAccent.withValues(alpha: 0.03)
          ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.2), 200, paint);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.8), 300, paint);
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.1),
      150,
      paint..color = AppTheme.secondaryAccent.withValues(alpha: 0.02),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
