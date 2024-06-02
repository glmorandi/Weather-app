import 'package:flutter/material.dart';
import 'package:weather/model/hourly.dart';

class HourlyDetail extends StatelessWidget {
  final String date;
  final HourlyWeather hourlyWeatherData;

  const HourlyDetail({required this.date, required this.hourlyWeatherData, super.key});

  @override
  Widget build(BuildContext context) {
    final hourlyDataForDate = extractHourlyDataForDate(date);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hourly Weather Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Hourly Weather for $date',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Display hourly weather details
            for (var entry in hourlyDataForDate) ...[
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Time: ${entry['time']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Temperature: ${entry['temperature']} °C',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Precipitation: ${entry['precipitation']} mm',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Weather Code: ${entry['weather_code']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Wind Speed: ${entry['wind_speed']} km/h',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> extractHourlyDataForDate(String date) {
    final times = hourlyWeatherData.time;
    final temperatures = hourlyWeatherData.temperature;
    final precipitations = hourlyWeatherData.precipitation;
    final weatherCodes = hourlyWeatherData.weatherCode;
    final windSpeeds = hourlyWeatherData.windSpeed;

    List<Map<String, dynamic>> hourlyDataForDate = [];

    for (int i = 0; i < times.length; i++) {
      if (times[i].startsWith(date)) {
        hourlyDataForDate.add({
          'time': times[i],
          'temperature': temperatures.isNotEmpty ? temperatures[i] : 'N/A',
          'precipitation': precipitations.isNotEmpty ? precipitations[i] : 'N/A',
          'weather_code': weatherCodes.isNotEmpty ? weatherCodes[i] : 'N/A',
          'wind_speed': windSpeeds.isNotEmpty ? windSpeeds[i] : 'N/A',
        });
      }
    }

    return hourlyDataForDate;
  }
}
