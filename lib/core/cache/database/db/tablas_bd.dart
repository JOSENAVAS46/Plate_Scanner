class TablasBd {
  static String nombreTablaHistory = 'HISTORY';
  static String tablaHistory = '''
    CREATE TABLE $nombreTablaHistory(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      tipo TEXT,
      objeto TEXT,
      base64Img TEXT DEFAULT NULL
    );
  ''';
}
