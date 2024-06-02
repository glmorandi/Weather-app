
import 'package:flutter/material.dart';
import 'package:weather/helper/weather_service.dart';
import 'package:weather/model/weather_data.dart';
import 'package:weather/screens/current.dart';
import 'package:weather/screens/daily_screen.dart';

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
              // Display a loading indicator while waiting for data
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Getting the weather info for your location"),
                  SizedBox(height: 16.0),
                  CircularProgressIndicator(),
              ],
              );
            } else if (snapshot.hasError) {
              // Display an error message if there's an error
              return Text('Error: ${snapshot.error}');
            } else {
              // Display the weather data once it's loaded
              final weatherData = snapshot.data!;
              return ListView(
                children: [
                  CurrentWeatherScreen(weatherData),
                  DailyWeatherScreen(weatherData),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}