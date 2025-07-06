import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// This class represents a connection with the SQLite database
class DBConnection {
  static const int version = 1;
  static const String dbName = 'weather.db';

  Future<Database> getDatabase() async {
    final dbPath = join(await getDatabasesPath(), dbName);

    return openDatabase(
      dbPath,
      version: version,
      onCreate: (db, version) async {
        await db.execute(WeatherTable.createTable);
      },
    );
  }
}

/// This class represents a table on the SQLite database
class WeatherTable {
  static const String tableName = 'weather';

  static const String city = 'city';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String main = 'main';
  static const String description = 'description';
  static const String temperature = 'temperature';
  static const String maxTemp = 'maxTemp';
  static const String minTemp = 'minTemp';
  static const String feelsLike = 'feelsLike';
  static const String humidity = 'humidity';
  static const String pressure = 'pressure';
  static const String rain = 'rain';
  static const String windDirection = 'windDirection';
  static const String windSpeed = 'windSpeed';

  static const String createTable = '''
  CREATE TABLE $tableName(
    $city TEXT PRIMARY KEY,
    $latitude REAL,
    $longitude REAL,
    $main TEXT,
    $description TEXT,
    $temperature REAL,
    $maxTemp REAL,
    $minTemp REAL,
    $feelsLike REAL,
    $humidity INTEGER,
    $pressure INTEGER,
    $rain REAL,
    $windDirection INTEGER,
    $windSpeed REAL
  );
  ''';
}
