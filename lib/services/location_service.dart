import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  /// Contains the [GeoCode API Key] retrieved from the [.env] file
  static String apiKey = dotenv.env['GEOCODE_API_KEY']!;

  /// Returns an [Address] based on the current [Position]
  static Future<Address?> getAddress({required Position position}) async {
    final GeoCode geoCode = GeoCode(apiKey: apiKey);

    final address = await geoCode.reverseGeocoding(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    return address;
  }

  /// Returns the current [Position]
  static Future<Position?> getPosition() async {
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      return null;
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.low),
    );

    return position;
  }
}
