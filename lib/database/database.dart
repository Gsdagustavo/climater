import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/weather_data.dart';

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

/// This class is a controller for making operations (insert, select) in the Weather table
class WeatherController {
  Future<void> insert({required WeatherData weatherData}) async {
    final startTime = DateTime.now();
    final db = await DBConnection().getDatabase();

    final json = weatherData.toJson();

    // deletes the last weather data in the table
    await db.delete(WeatherTable.tableName);

    // adds the new weather data into the table
    await db.insert(WeatherTable.tableName, json);

    final endTime = DateTime.now();
    final deltaTime = endTime.difference(startTime);

    debugPrint('Insert took ${deltaTime.inMilliseconds} ms');
  }

  Future<Map<String, dynamic>?> select() async {
    final startTime = DateTime.now();

    final db = await DBConnection().getDatabase();
    final result = await db.query(WeatherTable.tableName);

    final endTime = DateTime.now();
    final deltaTime = endTime.difference(startTime);

    debugPrint('Select took ${deltaTime.inMilliseconds} ms');
    // debugPrint('DB Select result length: ${result.length}');

    if (result.isEmpty) {
      return null;
    }

    // since the table will have only 1 row always, it is safe to return the
    // first index of the list
    return result[0];
  }
}
