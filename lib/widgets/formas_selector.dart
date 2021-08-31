import 'dart:math';

import 'package:flutter/material.dart';
import 'package:formas_colores/models/combinacion_model.dart';
import 'package:formas_colores/provider/data_provider.dart';
import 'package:formas_colores/widgets/painter_triangulos_widget.dart';

class FormasSelector extends StatelessWidget {
  final Random random = new Random();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CombinacionesProvider.seleccionStreamController,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        final CombinacionModel combinacionModel = snapshot.data;
        double randomNumber = random.nextDouble();
        switch (combinacionModel.forma.descripcion) {
          case 'Triangulo':
            return PainterTrianguloWidget(
              color: combinacionModel.color.color,
              base: randomNumber,
            );
          case 'Circulo':
            return PainterCirculoWidget(
              color: combinacionModel.color.color,
              base: randomNumber,
            );
          case 'Rectangulo':
            return PainterCuadradoWidget(
              color: combinacionModel.color.color,
              base: randomNumber,
            );
          default:
            return Container();
        }
      },
    );
  }
}
