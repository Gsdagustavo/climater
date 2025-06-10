import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  /// Returns the current [Position]
  static Future<Position?> getPosition() async {
    print('Get position called');
    final startTime = DateTime.now();

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

    final endTime = DateTime.now();
    final deltaTime = endTime.difference(startTime);
    print('Getting position took ${deltaTime.inMilliseconds} ms');

    return position;
  }
}
