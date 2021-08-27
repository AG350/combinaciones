import 'dart:convert';

import 'package:formas_colores/models/color_model.dart';
import 'package:formas_colores/models/forma_model.dart';

class CombinacionModel {
    CombinacionModel({
        required this.color,
        required this.forma,
        required this.idFirebase,
    });

    ColorModel color;
    FormaModel forma;
    String idFirebase;

    factory CombinacionModel.fromJson(String str) => CombinacionModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CombinacionModel.fromMap(Map<String, dynamic> json) => CombinacionModel(
        color: ColorModel.fromJson(json["colores"]),
        forma: FormaModel.fromJson(json["formas"]),
        idFirebase: json["idFirebase"],
    );

    Map<String, dynamic> toMap() => {
        "colores": color.toMap(),
        "formas": forma.toMap(),
        "idFirebase": idFirebase,
    };
}