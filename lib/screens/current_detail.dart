import 'package:flutter/material.dart';
import 'package:weather/model/weather_data.dart';

class CurrentDetail extends StatelessWidget {
  final WeatherData weatherData;

  const CurrentDetail(this.weatherData, {super.key});

  @override
  Widget build(BuildContext context) {
    final hourlyWeather = weatherData.hourly;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hourly Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Hourly Weather',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Display hourly weather details using ListView.builder
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: hourlyWeather.time.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time: ${hourlyWeather.time[index]}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Temperature: ${hourlyWeather.temperature[index]} °C',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Precipitation: ${hourlyWeather.precipitation[index]} mm',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Weather Code: ${hourlyWeather.weatherCode[index]}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Wind Speed: ${hourlyWeather.windSpeed[index]} km/h',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
