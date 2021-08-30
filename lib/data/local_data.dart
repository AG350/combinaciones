import 'dart:io';
import 'package:formas_colores/models/color_model.dart';
import 'package:formas_colores/models/combinacion_model.dart';
import 'package:formas_colores/models/forma_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class Dbase {
  static Database? _database;
  static final Dbase _db = new Dbase._();

  Dbase._();

  factory Dbase() {
    return _db;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await iniDB();
    return _database!;
  }

  Future<Database> iniDB() async {
    //Path donde esta la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'combinacionesBase.db');
    print('=======================Base===================================');
    print(path);
    return await openDatabase(
      path,
      version: 2,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''CREATE TABLE Combinaciones (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            idColor TEXT,
            idForma TEXT, 
            descripcion TEXT, 
            idFirebase TEXT DEFAULT ''
            )''');
      },
    );
  }

  Future<bool> guardaCombinacion(CombinacionModel combinacion) async {
    final _combinacion = await obtenerCombinacion(combinacion);
    if (_combinacion.id != null) {
      final res = await _modificaCombinacion(combinacion);
      if (res > 0) return true;
    } else {
      final res = await _agregaCombinacion(combinacion);
      if (res > 0) return true;
    }
    return false;
  }

  Future<int> _agregaCombinacion(CombinacionModel combinacion) async {
    int res = 0;

    try {
      final db = await database;
      res = await db.rawInsert('''
      INSERT INTO Combinaciones( idColor, idForma, descripcion) 
      VALUES ( '${combinacion.color.id}','${combinacion.forma.id}', '${combinacion.descripcion}')
    ''');
    } catch (errorsql) {
      print(errorsql.toString());
    } finally {}
    return res;
  }

  Future<int> _modificaCombinacion(CombinacionModel combinacionModel) async {
    int res = 0;

    try {
      if (combinacionModel.id != null) {
        final db = await database;
        res = await db.update('Usuarios', combinacionModel.toMap(), where: 'id = ?', whereArgs: [combinacionModel.id]);
      }
    } catch (errorsql) {
      print(errorsql.toString());
    }
    return res;
  }

  Future<CombinacionModel> obtenerCombinacion(CombinacionModel combinacionModel) async {
    CombinacionModel combinacionRes = new CombinacionModel(
      color: new ColorModel(color: '', descripcionColor: '', id: ''),
      forma: new FormaModel(descripcion: '', id: ''),
      descripcion: '',
    );
    try {
      final db = await database;
      final res = await db
          .query('Combinaciones', where: 'idColor = ? and idForma = ?', whereArgs: [combinacionModel.color.id, combinacionModel.forma.id]);
      if (res.isNotEmpty) combinacionRes = CombinacionModel.fromMap(res.first);
    } catch (errorsql) {
      print(errorsql.toString());
    } finally {}

    return combinacionRes;
  }

  Future<List<CombinacionModel>> obtenerListaCombinaciones() async {
    List<CombinacionModel> lstCombinaciones = [];
    try {
      final db = await database;
      final res = await db.query('Combinaciones', orderBy: 'descripcion');
      lstCombinaciones = (res.isNotEmpty) ? res.map((item) => CombinacionModel.fromMap(item)).toList() : [];
    } catch (errorsql) {
      print(errorsql.toString());
    } finally {}
    return lstCombinaciones;
  }
}
