import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider with ChangeNotifier {
  final SharedPreferences? sharedPreferences;

  LocationProvider({required this.sharedPreferences});

  Placemark _address = Placemark();

  Placemark get address => _address;
  Position _currentLocation = Position(
    latitude: 0, longitude: 0,
    speed: 1, speedAccuracy: 1, altitude: 1, accuracy: 1, heading: 1, timestamp: DateTime.now(),
    altitudeAccuracy: 1, headingAccuracy: 1,
  );
  Position get currentLocation => _currentLocation;

  Future<Position> locateUser() async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void getUserLocation() async {
    _currentLocation = await locateUser();
    var currentAddresses = await placemarkFromCoordinates(_currentLocation.latitude, _currentLocation.longitude);
    _address = currentAddresses.first;
    notifyListeners();
  }
}
