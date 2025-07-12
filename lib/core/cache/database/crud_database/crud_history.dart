import 'package:plate_scanner_app/core/cache/database/db/data_base_ope.dart';
import 'package:plate_scanner_app/core/cache/database/db/tablas_bd.dart';
import 'package:plate_scanner_app/features/_other/data/models/aux_history_converter_model.dart';

class CrudHistory {
  final dbProvider = DataBase.instance;
  final String tableName = TablasBd.nombreTablaHistory;

  Future<int> insert(AuxHistoryConverterModel user) async {
    try {
      final db = await dbProvider.database;
      final res = await db.insert(tableName, user.toJson());
      return res;
    } catch (e) {
      print('Error al eliminar tabla: $e');
      return 0;
    }
  }

  Future<List<AuxHistoryConverterModel>> readAll() async {
    try {
      final db = await dbProvider.database;
      final res = await db.query(tableName);
      return res.isNotEmpty
          ? res.map((e) => AuxHistoryConverterModel.fromJson(e)).toList()
          : [];
    } catch (e) {
      print('Error al leer todos los registros: $e');
      return [];
    }
  }

  Future<List<AuxHistoryConverterModel>> getHistoryByTipo(String tipo) async {
    try {
      final db = await dbProvider.database;
      final res = await db.query(
        tableName,
        where: 'tipo = ?',
        whereArgs: [tipo],
      );
      return res.isNotEmpty
          ? res.map((e) => AuxHistoryConverterModel.fromJson(e)).toList()
          : [];
    } catch (e) {
      print('Error al obtener historial por tipo: $e');
      return [];
    }
  }

  Future<int> deleteHistoryByTipo(String tipo) async {
    final db = await dbProvider.database;
    return await db.delete(
      tableName,
      where: 'tipo = ?',
      whereArgs: [tipo],
    );
  }

  Future<int> update(AuxHistoryConverterModel user) async {
    try {
      final db = await dbProvider.database;
      final res = await db.update(
        tableName,
        user.toJson(),
        where: 'id = ?',
        whereArgs: [user.id],
      );
      return res;
    } catch (e) {
      print('Error al actualizar registro: $e');
      return 0;
    }
  }

  Future<int> delete(int id) async {
    try {
      final db = await dbProvider.database;
      final res = await db.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
      return res;
    } catch (e) {
      print('Error al eliminar registro: $e');
      return 0;
    }
  }

  Future<void> deleteAll() async {
    try {
      final db = await dbProvider.database;
      await db.delete(tableName);
    } catch (e) {
      print('Error al eliminar todos los registros: $e');
    }
  }
}
