import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/helper/api_service.dart';
import 'package:weather/helper/location_manager.dart';
import 'package:weather/model/weather_data.dart';
import 'package:weather/notifications/firebase.dart';
import 'package:weather/notifications/local.dart';
import 'package:weather/screens/current_detail.dart';
import 'package:weather/screens/temperature.dart';
import 'package:weather/screens/home_screen.dart';
import 'package:workmanager/workmanager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

const String fetchWeatherTask = "fetchWeatherTask";
const String updateLocationTask = "updateLocationTask";

Position? currentPosition;

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchWeatherTask:
        try {
          currentPosition ??= await LocationManager.getCurrentLocation();
          double latitude = currentPosition!.latitude;
          double longitude = currentPosition!.longitude;
          ApiService apiService = ApiService(latitude, longitude);
          WeatherData weatherData = await apiService.fetchWeatherData();

          await doNotification(weatherData);

          print("Weather Data: ${weatherData.toJson()}");
        } catch (e) {
          print("Error fetching weather data: $e");
        }
        break;
      case updateLocationTask:
        try {
          currentPosition = await LocationManager.getCurrentLocation();
          print("Updated Location: Lat: ${currentPosition?.latitude}, Lon: ${currentPosition?.longitude}");
        } catch (e) {
          print("Error updating location: $e");
        }
        break;
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  FireBaseManager().initialize(
    
  );

  await initializeNotifications();

  currentPosition = await LocationManager.getCurrentLocation();

  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  Workmanager().registerPeriodicTask(
    "1",
    fetchWeatherTask,
    initialDelay: const Duration(minutes: 15),
    frequency: const Duration(minutes: 20),
  );

  Workmanager().registerPeriodicTask(
    "2",
    updateLocationTask,
    initialDelay: const Duration(minutes: 10),
    frequency: const Duration(minutes: 15),
  );

  runApp(const Home());
}
