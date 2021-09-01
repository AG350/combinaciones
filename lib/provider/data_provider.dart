import 'dart:async';

import 'package:formas_colores/data/extern_data.dart';
import 'package:formas_colores/data/local_data.dart';
import 'package:formas_colores/models/models.dart';

class CombinacionesProvider {
  static CombinacionModel combinacionSeleccionada = new CombinacionModel(
    color: new ColorModel(color: '', descripcionColor: '', id: ''),
    forma: new FormaModel(descripcion: '', id: ''),
    descripcion: '',
  );

  static List<CombinacionModel> listadoCombinaciones = [];
  static List<CombinacionModel> listadoSincronizado = [];
  static List<ColorModel> listadoColores = [];
  static List<FormaModel> listadoformas = [];
  final db = new LocalData();
  final dbe = new ExternData();

  static final StreamController<List<CombinacionModel>> _combinacionesStreamController = new StreamController.broadcast();
  static final StreamController<CombinacionModel> _seleccionStreamController = new StreamController.broadcast();
  static final StreamController<List<ColorModel>> _colorStreamController = new StreamController.broadcast();
  static final StreamController<List<FormaModel>> _formaStreamController = new StreamController.broadcast();

  static Stream<CombinacionModel> get seleccionStreamController => _seleccionStreamController.stream;
  static Stream<List<CombinacionModel>> get combinacionesStreamController => _combinacionesStreamController.stream;
  static Stream<List<ColorModel>> get colorStreamController => _colorStreamController.stream;
  static Stream<List<FormaModel>> get formaStreamController => _formaStreamController.stream;

  static void formulario() {
    _seleccionStreamController.add(combinacionSeleccionada);
  }

  void combinar() async {
    await db.guardaCombinacion(combinacionSeleccionada);
    cargarCombinaciones();
  }

  void cargarFormaColor() async {
    listadoColores = await dbe.loadColors();
    listadoformas = await dbe.loadForms();
    _colorStreamController.add(listadoColores);
    _formaStreamController.add(listadoformas);
  }

  void sincronizarCombinaciones() async {
    listadoCombinaciones = await db.obtenerListaCombinaciones();
    for (var item in listadoCombinaciones) {
      if (item.idFirebase == null) {
        item.idFirebase = await dbe.createCombinacion(item);
        db.modificaCombinacion(item);
      }
    }
    cargarCombinaciones();
  }

  void limpiarSeleccion() async {
    combinacionSeleccionada = new CombinacionModel(
      color: new ColorModel(color: '', descripcionColor: '', id: ''),
      forma: new FormaModel(descripcion: '', id: ''),
      descripcion: '',
    );
  }

  void cargarCombinaciones() async {
    listadoCombinaciones = await db.obtenerListaCombinaciones();
    CombinacionesProvider().limpiarSeleccion();
    _combinacionesStreamController.add(listadoCombinaciones);
  }

  dispose() {
    _combinacionesStreamController.close();
    _seleccionStreamController.close();
    _colorStreamController.close();
    _formaStreamController.close();
  }
}
