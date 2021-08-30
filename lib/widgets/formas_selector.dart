import 'package:flutter/material.dart';
import 'package:formas_colores/widgets/painter_triangulos_widget.dart';

class FormasSelector extends StatelessWidget {
  final String forma;
  final String color;
  final double base;

  const FormasSelector({
    required this.forma,
    required this.color,
    required this.base,
  });
  @override
  Widget build(BuildContext context) {
    switch (forma) {
      case 'Triangulo':
        return PainterTrianguloWidget(
          color: color,
          base: base,
        );
      case 'Circulo':
        return PainterCirculoWidget(
          color: color,
          base: base,
        );
      case 'Cuadrado':
        return PainterCuadradoWidget(
          color: color,
          base: base,
        );
      default:
        return Container();
    }
  }
}
