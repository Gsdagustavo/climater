import 'package:climater/entities/weather_data.dart';
import 'package:climater/modules/weather_data/weather_data_repository.dart';

abstract class WeatherDataUseCase {
  Future<WeatherData?> loadWeatherData();

  Future<void> saveWeatherData(WeatherData weatherData);
}

class WeatherDataUseCaseImpl implements WeatherDataUseCase {
  final WeatherDataRepositoryImpl _weatherDataRepository;

  WeatherDataUseCaseImpl(this._weatherDataRepository);

  @override
  Future<WeatherData?> loadWeatherData() async {
    return await _weatherDataRepository.loadWeatherData();
  }

  @override
  Future<void> saveWeatherData(WeatherData? weatherData) async {
    if (weatherData == null) throw Exception('Invalid Weather Data');

    await _weatherDataRepository.saveWeatherData(weatherData);
  }
}
