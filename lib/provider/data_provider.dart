import 'dart:async';

import 'package:formas_colores/data/local_data.dart';
import 'package:formas_colores/models/models.dart';

class CombinacionesProvider {
  static CombinacionModel combinacionSeleccionada = new CombinacionModel(
    color: new ColorModel(color: '', descripcionColor: '', id: ''),
    forma: new FormaModel(descripcion: '', id: ''),
    descripcion: '',
  );

  List<ColorModel> get colores => <ColorModel>[
        ColorModel(color: 'FFFF00', descripcionColor: 'Amarillo', id: '003'),
        ColorModel(color: '0000FF', descripcionColor: 'Azul', id: '002'),
        ColorModel(color: 'FF0000', descripcionColor: 'Rojo', id: '001'),
      ];

  List<FormaModel> get formas => <FormaModel>[
        FormaModel(descripcion: 'Triangulo', id: 'asd10sz0dz'),
        FormaModel(descripcion: 'Circulo', id: '1as23d1as23'),
        FormaModel(descripcion: 'Cuadrado', id: '3z21ca23s1d'),
      ];

  static List<CombinacionModel> listadoCombinaciones = [];
  final db = new Dbase();

  static final StreamController<List<CombinacionModel>> _combinacionesStreamController = new StreamController.broadcast();
  static final StreamController<CombinacionModel> _seleccionStreamController = new StreamController.broadcast();

  static Stream<CombinacionModel> get seleccionStreamController => _seleccionStreamController.stream;
  static Stream<List<CombinacionModel>> get combinacionesStreamController => _combinacionesStreamController.stream;

  static void formulario() {
    _seleccionStreamController.add(combinacionSeleccionada);
  }

  void combinar() async {
    await db.guardaCombinacion(combinacionSeleccionada);
    cargarCombinaciones();
  }

  void cargarCombinaciones() async {
    listadoCombinaciones = await db.obtenerListaCombinaciones();
    _combinacionesStreamController.add(listadoCombinaciones);
  }

  dispose() {
    _combinacionesStreamController.close();
    _seleccionStreamController.close();
  }
}
