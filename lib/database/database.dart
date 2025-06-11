import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBConnection {
  static const int version = 1;
  static const String dbName = 'weather.db';

  Future<Database> getDatabase() async {
    final dbPath = join(await getDatabasesPath(), dbName);

    return openDatabase(dbPath, version: version, onCreate: (db, version) async {
      // await db.execute('');
    });
  }
}

