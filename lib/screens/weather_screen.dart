import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/helper/api_service.dart';
import 'package:weather/helper/location_manager.dart';
import 'package:weather/helper/weather_service.dart';
import 'package:weather/model/weather_data.dart';
import 'package:weather/notifications/local.dart';
import 'package:weather/screens/current.dart';
import 'package:weather/screens/daily_screen.dart';

void _generateNotification() async {
Position? currentPosition;
            currentPosition ??= await LocationManager.getCurrentLocation();
          double latitude = currentPosition!.latitude;
          double longitude = currentPosition!.longitude;
          ApiService apiService = ApiService(latitude, longitude);
          WeatherData weatherData = await apiService.fetchWeatherData();

    await doNotification(weatherData);
  }

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WeatherWidget(),
    );
  }
}

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late Future<Map<String, dynamic>> testData;
  late Future<WeatherData> weatherData;

  @override
  void initState() {
    super.initState();
    weatherData = fetchWeatherData();
  }

  Future<WeatherData> fetchWeatherData() async {
    WeatherData weather = await WeatherService.getWeatherData();
    return weather;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<WeatherData>(
          future: weatherData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Getting the weather info for your location"),
                  SizedBox(height: 16.0),
                  CircularProgressIndicator(),
              ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final weatherData = snapshot.data!;
              return ListView(
                children: [
                  CurrentWeatherScreen(weatherData),
                  DailyWeatherScreen(weatherData),
                  const ElevatedButton(
            onPressed: _generateNotification,
            child: Text('Generate Notification'),
          ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}