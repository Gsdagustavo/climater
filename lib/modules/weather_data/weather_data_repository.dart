import 'package:climater/database/database.dart';
import 'package:climater/entities/weather_data.dart';
import 'package:sqflite/sqflite.dart';

abstract class WeatherDataRepository {
  Future<WeatherData?> loadWeatherData();

  Future<void> saveWeatherData(WeatherData weatherData);
}

class WeatherDataRepositoryImpl implements WeatherDataRepository {
  late final Future<Database> _db = DBConnection().getDatabase();

  @override
  Future<WeatherData?> loadWeatherData() async {
    final db = await _db;

    final result = await db.query(WeatherTable.tableName);
    if (result.isEmpty) return null;

    return WeatherData.fromMap(map: result.first);
  }

  @override
  Future<void> saveWeatherData(WeatherData weatherData) async {
    final db = await _db;
    await db.insert(WeatherTable.tableName, weatherData.toJson());
  }
}
