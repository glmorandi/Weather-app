class CurrentWeather {
  final String time;
  final int interval;
  final double temperature;
  final int relativeHumidity;
  final double apparentTemperature;
  final int weatherCode;
  final double windSpeed;

  CurrentWeather({
    required this.time,
    required this.interval,
    required this.temperature,
    required this.relativeHumidity,
    required this.apparentTemperature,
    required this.weatherCode,
    required this.windSpeed,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      time: json['time'],
      interval: json['interval'],
      temperature: json['temperature_2m'],
      relativeHumidity: json['relative_humidity_2m'],
      apparentTemperature: json['apparent_temperature'],
      weatherCode: json['weather_code'],
      windSpeed: json['wind_speed_10m'],
    );
  }

  Map<String, dynamic> toJson() => {
        'time': time,
        'interval': interval,
        'temperature_2m': temperature,
        'relative_humidity_2m': relativeHumidity,
        'apparent_temperature': apparentTemperature,
        'weather_code': weatherCode,
        'wind_speed_10m': windSpeed,
      };
}
