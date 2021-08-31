import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:formas_colores/models/models.dart';

class ExternData {
  final String _baseUrl = 'formas-colores-default-rtdb.firebaseio.com';

  Future<List<ColorModel>> loadColors() async {
    List<ColorModel> colors = [];
    final url = Uri.https(_baseUrl, '/colores.json');
    final response = await http.get(url);

    final Map<String, dynamic> colorMap = json.decode(response.body);

    colorMap.forEach((key, value) {
      final tempColor = ColorModel.fromMap(value);
      tempColor.id = key;
      colors.add(tempColor);
    });

    return colors;
  }

  Future<List<FormaModel>> loadForms() async {
    List<FormaModel> forms = [];
    final url = Uri.https(_baseUrl, '/formas.json');
    final response = await http.get(url);

    final Map<String, dynamic> formMap = json.decode(response.body);

    formMap.forEach((key, value) {
      final tempForm = FormaModel.fromMap(value);
      tempForm.id = key;
      forms.add(tempForm);
    });

    return forms;
  }

  Future<String> createCombinacion(CombinacionModel combinacionModel) async {
    final url = Uri.https(_baseUrl, 'combinaciones.json');
    final response = await http.post(url, body: combinacionModel.toJson());
    final decodedData = json.decode(response.body);
    combinacionModel.idFirebase = decodedData['name'];
    return combinacionModel.idFirebase!;
  }
}
