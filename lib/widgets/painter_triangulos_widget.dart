import 'dart:math';

import 'package:flutter/material.dart';

class PainterTrianguloWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: CustomPaint(
        painter: _TrianguloPainter(),
      ),
    );
  }
}

class _TrianguloPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();
    //propiedades
    paint.color = Color(0xff615AAB);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    final path = new Path();

    // Dibujar con path y paint
    path.moveTo(size.width * 0.25, size.height * 0.4);
    path.lineTo(size.width * 0.5, size.height * 0.2);
    path.lineTo(size.width * 0.75, size.height * 0.4);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PainterCuadradoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: CustomPaint(
        painter: _CuadradoPainter(),
      ),
    );
  }
}

class _CuadradoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();
    //propiedades
    paint.color = Color(0xff615AAB);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    final path = new Path();

    // Dibujar con path y paint
    path.moveTo(size.width * 0.25, size.height * 0.4);
    path.lineTo(size.width * 0.25, size.height * 0.2);
    path.lineTo(size.width * 0.75, size.height * 0.2);
    path.lineTo(size.width * 0.75, size.height * 0.4);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PainterRedondoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: CustomPaint(
        painter: _RedondoPainter(),
      ),
    );
  }
}

class _RedondoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();
    //propiedades
    paint.color = Color(0xff615AAB);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    Offset center = new Offset(size.width * 0.5, size.height * 0.5);
    double radius = min(size.width * 0.22, size.height * 0.2);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
