import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:formas_colores/models/color_model.dart';
import 'package:formas_colores/models/combinacion_model.dart';
import 'package:formas_colores/models/forma_model.dart';
import 'package:formas_colores/provider/data_provider.dart';
import 'package:formas_colores/widgets/widgets.dart';

class AnimatedSelection extends StatefulWidget {
  @override
  _AnimatedSelectionState createState() => _AnimatedSelectionState();
}

class _AnimatedSelectionState extends State<AnimatedSelection> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotacion;
  late Animation<double> agrandar;
  @override
  void initState() {
    controller = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 1000),
    );
    rotacion = Tween(begin: 0.0, end: 0.5 * Math.pi).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
      ),
    );
    agrandar = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.decelerate,
      ),
    );
    CombinacionesProvider.seleccionStreamController.listen((event) {
      if (controller.status == AnimationStatus.completed) {
        controller.reset();
      }
      controller.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: FormasSelector(),
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: rotacion.value,
          child: Transform.scale(
            scale: agrandar.value,
            child: child,
          ),
        );
      },
    );
  }
}
