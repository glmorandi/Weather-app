import 'package:geolocator/geolocator.dart';

class LocationManager {
  static Future<bool> isLocationActive() async {
    final bool servicestatus = await Geolocator.isLocationServiceEnabled();
    return servicestatus;
  }
  static Future<bool> hasLocationPermission() async {
    LocationPermission status = await Geolocator.checkPermission();
    if(status == LocationPermission.denied){
      status = await Geolocator.requestPermission();
    }
    return status == LocationPermission.always || status == LocationPermission.whileInUse;
  }

  static Future<Position?> getCurrentLocation() async {
    if (await hasLocationPermission()) {
      if(await isLocationActive()){
      try {
        return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      } catch (e) {
        print('Error getting current location: $e');
        return null;
      }} else {
        print('Location is not active.');
        return null;
      }
    } else {
      print('Location permission not granted.');
      return null;
    }
  }
}
