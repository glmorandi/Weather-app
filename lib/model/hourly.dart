class HourlyWeather {
  final List<String> time;
  final List<double> temperature;
  final List<double> precipitation;
  final List<int> weatherCode;
  final List<double> windSpeed;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.precipitation,
    required this.weatherCode,
    required this.windSpeed,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: List<String>.from(json['time']),
      temperature: List<double>.from(json['temperature_2m']),
      precipitation: List<double>.from(json['precipitation']),
      weatherCode: List<int>.from(json['weather_code']),
      windSpeed: List<double>.from(json['wind_speed_10m']),
    );
  }

  Map<String, dynamic> toJson() => {
        'time': time,
        'temperature_2m': temperature,
        'precipitation': precipitation,
        'weather_code': weatherCode,
        'wind_speed_10m': windSpeed,
      };
}