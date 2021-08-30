import 'dart:math';

import 'package:flutter/material.dart';

class PainterTrianguloWidget extends StatelessWidget {
  final String color;
  final double base;

  const PainterTrianguloWidget({required this.color, required this.base});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: CustomPaint(
        painter: _TrianguloPainter(color, base),
      ),
    );
  }
}

class _TrianguloPainter extends CustomPainter {
  final String color;
  final double base;

  _TrianguloPainter(this.color, this.base);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();
    //propiedades
    paint.color = Color(int.parse("0xFF" + color));
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    final path = new Path();

    // Dibujar con path y paint
    path.moveTo(size.width * 0.25, size.height * base);
    path.lineTo(size.width * 0.5, size.height * base);
    path.lineTo(size.width * 0.75, size.height * (1.0 - base));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PainterCuadradoWidget extends StatelessWidget {
  final String color;
  final double base;

  const PainterCuadradoWidget({required this.color, required this.base});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: CustomPaint(
        painter: _CuadradoPainter(color, base),
      ),
    );
  }
}

class _CuadradoPainter extends CustomPainter {
  final String color;
  final double base;

  _CuadradoPainter(this.color, this.base);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();
    //propiedades
    paint.color = Color(int.parse("0xFF" + color));
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    final path = new Path();

    // Dibujar con path y paint
    path.moveTo(size.width * base, size.height * base);
    path.lineTo(size.width * base, size.height * 0.2);
    path.lineTo(size.width * (1 - base), size.height * 0.2);
    path.lineTo(size.width * (1 - base), size.height * base);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PainterCirculoWidget extends StatelessWidget {
  final String color;
  final double base;

  const PainterCirculoWidget({required this.color, required this.base});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: CustomPaint(
        painter: _CirculoPainter(color, base),
      ),
    );
  }
}

class _CirculoPainter extends CustomPainter {
  final String color;
  final double base;

  _CirculoPainter(this.color, this.base);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();
    //propiedades
    paint.color = Color(int.parse("0xFF" + color));
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    Offset center = new Offset(size.width * 0.5, size.height * 0.5);
    double radius = min(size.width * base / 3, size.height * base);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
