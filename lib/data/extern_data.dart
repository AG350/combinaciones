import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:formas_colores/models/color_model.dart';
import 'package:formas_colores/models/combinacion_model.dart';
import 'package:http/http.dart' as http;

class CombinacionesService {
  final String _baseUrl = 'formas-colores-default-rtdb.firebaseio.com';
  final storage = new FlutterSecureStorage();
  final List<ColorModel> colors = [];

  loadColors() async {
    final url = Uri.https(_baseUrl, '/colores.json');
    final response = await http.get(url);

    final Map<String, dynamic> colorMap = json.decode(response.body);

    colorMap.forEach((key, value) {
      final tempColor = ColorModel.fromMap(value);
      this.colors.add(tempColor);
    });

    return this.colors;
  }

  loadForms() async {
    final url = Uri.https(_baseUrl, '/colores.json');
    final response = await http.get(url);

    final Map<String, dynamic> colorMap = json.decode(response.body);

    colorMap.forEach((key, value) {
      final tempColor = ColorModel.fromMap(value);
      this.colors.add(tempColor);
    });

    return this.colors;
  }

  syncCombinacion(CombinacionModel combinacionModel) async {
    final url = Uri.https(_baseUrl, 'combinaciones.json');
    final response = await http.post(url, body: combinacionModel.toJson());
    final decodedData = json.decode(response.body);
    combinacionModel.id = decodedData['id'];
  }
}
