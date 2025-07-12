import 'package:path/path.dart';
import 'package:plate_scanner_app/core/cache/database/db/tablas_bd.dart';
import 'package:sqflite/sqflite.dart';

class DataBase {
  static DataBase instance = DataBase._init();
  static Database? _database;
  DataBase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app.db');
    return await openDatabase(path,
        version: 1, onCreate: _createDB, onUpgrade: _upgradeDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(TablasBd.tablaHistory);
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion <= newVersion) {}
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
