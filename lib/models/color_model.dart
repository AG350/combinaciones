// To parse this JSON data, do
//
//     final color = colorFromMap(jsonString);

import 'dart:convert';

class ColorModel {
    ColorModel({
        required this.color,
        required this.descripcionColor,
        required this.id,
    });

    String color;
    String descripcionColor;
    String id;

    factory ColorModel.fromJson(String str) => ColorModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ColorModel.fromMap(Map<String, dynamic> json) => ColorModel(
        color: json["color"],
        descripcionColor: json["descripcionColor"],
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "color": color,
        "descripcionColor": descripcionColor,
        "id": id,
    };
}
