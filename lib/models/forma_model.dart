// To parse this JSON data, do
//
//     final forma = formaFromMap(jsonString);

import 'dart:convert';

class FormaModel {
  FormaModel({
    required this.descripcion,
    this.id,
  });

  String descripcion;
  String? id;

  factory FormaModel.fromJson(String str) => FormaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FormaModel.fromMap(Map<String, dynamic> json) => FormaModel(
        descripcion: json["descripcion"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "descripcion": descripcion,
        "id": id,
      };
}
