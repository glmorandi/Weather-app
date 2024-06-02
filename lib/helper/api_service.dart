import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/model/weather_data.dart';

class ApiService {
  final String baseUrl = "https://api.open-meteo.com/v1/forecast?";
  final String urlOptions = "current=temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,wind_speed_10m&hourly=temperature_2m,precipitation,weather_code,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min,uv_index_max,precipitation_probability_max,wind_speed_10m_max";
  final double latitude;
  final double longitude;

  ApiService(this.latitude, this.longitude);

  Future<WeatherData> fetchWeatherData() async {
    print("Sending a request!");
    final response = await http.get(Uri.parse('$baseUrl&latitude=$latitude&longitude=$longitude&$urlOptions'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return WeatherData.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
