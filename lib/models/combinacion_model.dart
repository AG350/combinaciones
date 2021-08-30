import 'dart:convert';

import 'package:formas_colores/models/color_model.dart';
import 'package:formas_colores/models/forma_model.dart';

class CombinacionModel {
  CombinacionModel({
    this.id,
    required this.color,
    required this.forma,
    required this.descripcion,
    this.idFirebase,
  });
  int? id;
  ColorModel color;
  FormaModel forma;
  String descripcion;
  String? idFirebase;

  factory CombinacionModel.fromJson(String str) => CombinacionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CombinacionModel.fromMap(Map<String, dynamic> json) => CombinacionModel(
        id: json["id"] ?? null,
        color: ColorModel.fromJson(json["colores"]),
        forma: FormaModel.fromJson(json["formas"]),
        descripcion: json["descripcion"],
        idFirebase: json["idFirebase"] ?? null,
      );

  Map<String, dynamic> toMap() => {
        "id": id ?? null,
        "colores": color.toMap(),
        "formas": forma.toMap(),
        "descripcion": descripcion,
        "idFirebase": idFirebase ?? null,
      };
}
