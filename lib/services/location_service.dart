import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

abstract class LocationService {
  /// Returns the current [Position]
  static Future<LocationData?> getPosition() async {
    debugPrint('Get position called');
    final startTime = DateTime.now();

    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    final endTime = DateTime.now();
    final deltaTime = endTime.difference(startTime);
    debugPrint('Getting position took ${deltaTime.inMilliseconds} ms');

    return await location.getLocation();
  }
}
