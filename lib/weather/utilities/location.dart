import 'dart:developer';
import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;
  bool? serviceEnabled;
  LocationPermission? permission;

  Future<void> getCurrentLocation() async {
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (serviceEnabled == false) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.low)
          .timeout(const Duration(seconds: 5));
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      log('Something goes wrong: $e');
    }
  }
}
