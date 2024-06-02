import 'package:flutter/material.dart';
import 'package:weather/model/weather_data.dart';
import 'package:weather/screens/hourly_detail.dart';

class DailyWeatherScreen extends StatelessWidget {
  final WeatherData weatherData;

  const DailyWeatherScreen(this.weatherData, {super.key});

  @override
  Widget build(BuildContext context) {
    final dailyWeatherData = weatherData.daily;

    return Card(
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daily Weather:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            for (int i = 0; i < dailyWeatherData.time.length; i++) ...[
              GestureDetector(
                onTap: () {
                  print(dailyWeatherData.time[i]);
                  print(weatherData.hourly.toJson());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HourlyDetail(
                        date: dailyWeatherData.time[i],
                        hourlyWeatherData: weatherData.hourly,
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    Text(
                      'Date: ${dailyWeatherData.time[i]}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Weather Code: ${dailyWeatherData.weatherCode[i]}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Max Temperature: ${dailyWeatherData.maxTemperature[i]} °C',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Min Temperature: ${dailyWeatherData.minTemperature[i]} °C',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'UV Index Max: ${dailyWeatherData.uvIndexMax[i]}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Precipitation Probability Max: ${dailyWeatherData.precipitationProbabilityMax[i]} %',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Wind Speed Max: ${dailyWeatherData.windSpeedMax[i]} km/h',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
