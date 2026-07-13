import 'package:flutter/material.dart';

class MinetLogo extends StatelessWidget {
  final double size;
  final Color? color;

  const MinetLogo({
    super.key,
    this.size = 60,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final logoColor = color ?? theme.colorScheme.primary;
    
    return CustomPaint(
      size: Size(size, size),
      painter: MinetLogoPainter(logoColor),
    );
  }
}

class MinetLogoPainter extends CustomPainter {
  final Color color;

  MinetLogoPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0;

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final rectSize = size.width * 0.6;
    final rectLeft = centerX - rectSize / 2;
    final rectTop = centerY - rectSize / 2;

    // Draw the red rectangle outline
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(rectLeft, rectTop, rectSize, rectSize),
      const Radius.circular(8),
    );
    canvas.drawRRect(rect, strokePaint);

    // Draw the stylized "M" shape inside
    final path = Path();
    final mWidth = rectSize * 0.6;
    final mHeight = rectSize * 0.6;
    final mLeft = centerX - mWidth / 2;
    final mTop = centerY - mHeight / 2;

    // Create the wavy "M" shape
    path.moveTo(mLeft, mTop + mHeight);
    path.quadraticBezierTo(
      mLeft + mWidth * 0.2, mTop + mHeight * 0.3,
      mLeft + mWidth * 0.4, mTop + mHeight * 0.2,
    );
    path.quadraticBezierTo(
      mLeft + mWidth * 0.6, mTop + mHeight * 0.1,
      mLeft + mWidth * 0.8, mTop + mHeight * 0.2,
    );
    path.quadraticBezierTo(
      mLeft + mWidth, mTop + mHeight * 0.3,
      mLeft + mWidth, mTop + mHeight,
    );

    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

