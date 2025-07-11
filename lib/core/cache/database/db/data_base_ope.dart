import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseOpe {
  static DataBaseOpe instance = DataBaseOpe._init();
  static Database? _database;
  DataBaseOpe._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'adm_app.db');
    return await openDatabase(path,
        version: 1, onCreate: _createDB, onUpgrade: _upgradeDB);
  }

  Future<void> _createDB(Database db, int version) async {
    //await db.execute(TablasBd.tablaUsuario);
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion <= newVersion) {}
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
