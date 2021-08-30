import 'dart:math';

import 'package:flutter/material.dart';
import 'package:formas_colores/widgets/painter_triangulos_widget.dart';

Random random = new Random();
double randomNumber = random.nextDouble();

class FormasSelector extends StatelessWidget {
  final String forma;
  final String color;

  const FormasSelector({
    required this.forma,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    switch (forma) {
      case 'Triangulo':
        return PainterTrianguloWidget(color: color);
      case 'Circulo':
        return PainterCirculoWidget(color: color);
      case 'Cuadrado':
        return PainterCuadradoWidget(
          color: color,
          base: randomNumber,
        );
      default:
        return Container();
    }
  }
}
