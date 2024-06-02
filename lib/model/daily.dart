class DailyWeather {
  final List<String> time;
  final List<int> weatherCode;
  final List<double> maxTemperature;
  final List<double> minTemperature;
  final List<double> uvIndexMax;
  final List<int> precipitationProbabilityMax;
  final List<double> windSpeedMax;

  DailyWeather({
    required this.time,
    required this.weatherCode,
    required this.maxTemperature,
    required this.minTemperature,
    required this.uvIndexMax,
    required this.precipitationProbabilityMax,
    required this.windSpeedMax,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      time: List<String>.from(json['time']),
      weatherCode: List<int>.from(json['weather_code']),
      maxTemperature: List<double>.from(json['temperature_2m_max']),
      minTemperature: List<double>.from(json['temperature_2m_min']),
      uvIndexMax: List<double>.from(json['uv_index_max']),
      precipitationProbabilityMax:
          List<int>.from(json['precipitation_probability_max']),
      windSpeedMax: List<double>.from(json['wind_speed_10m_max']),
    );
  }

  Map<String, dynamic> toJson() => {
        'time': time,
        'weather_code': weatherCode,
        'temperature_2m_max': maxTemperature,
        'temperature_2m_min': minTemperature,
        'uv_index_max': uvIndexMax,
        'precipitation_probability_max': precipitationProbabilityMax,
        'wind_speed_10m_max': windSpeedMax,
      };
}