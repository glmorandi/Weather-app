import 'package:weather/model/current.dart';
import 'package:weather/model/hourly.dart';
import 'package:weather/model/daily.dart';

class WeatherData {
  final double latitude;
  final double longitude;
  final double generationTimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final CurrentWeather current;
  final HourlyWeather hourly;
  final DailyWeather daily;

  WeatherData({
    required this.latitude,
    required this.longitude,
    required this.generationTimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      latitude: json['latitude'],
      longitude: json['longitude'],
      generationTimeMs: json['generationtime_ms'],
      utcOffsetSeconds: json['utc_offset_seconds'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezone_abbreviation'],
      elevation: json['elevation'],
      current: CurrentWeather.fromJson(json['current']),
      hourly: HourlyWeather.fromJson(json['hourly']),
      daily: DailyWeather.fromJson(json['daily']),
    );
  }

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'generationtime_ms': generationTimeMs,
        'utc_offset_seconds': utcOffsetSeconds,
        'timezone': timezone,
        'timezone_abbreviation': timezoneAbbreviation,
        'elevation': elevation,
        'current': current.toJson(),
        'hourly': hourly.toJson(),
        'daily': daily.toJson(),
      };
}
