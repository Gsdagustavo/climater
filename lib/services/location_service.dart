import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  /// Returns an [Address] based on the current [Position]
  static Future<Address?> getAddress({required Position position}) async {
    final address = await GeoCode().reverseGeocoding(
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
      locationSettings: LocationSettings(accuracy: LocationAccuracy.medium),
    );

    return position;
  }
}
