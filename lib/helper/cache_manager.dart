import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:weather/model/weather_data.dart';

class CacheManager {
  static const String cacheKey = 'weather_data';
  static const String timestampKey = 'weather_data_timestamp';

  static Future<WeatherData?> getCachedWeatherData() async {
    final fileInfo = await DefaultCacheManager().getFileFromCache(cacheKey);
    if (fileInfo != null) {
      final jsonString = await fileInfo.file.readAsString();
      final jsonData = json.decode(jsonString);
      final weatherData = WeatherData.fromJson(jsonData);

      final timestampInfo = await DefaultCacheManager().getFileFromCache(timestampKey);
      if (timestampInfo != null) {
        final timestampString = await timestampInfo.file.readAsString();
        final timestamp = DateTime.parse(timestampString);
        
        if (_isCacheExpired(timestamp)) {
          // Cache expired, delete the cache files
          await DefaultCacheManager().removeFile(cacheKey);
          await DefaultCacheManager().removeFile(timestampKey);
          return null;
        }
        return weatherData;
      } else {
        // No timestamp found, consider cache expired
        await DefaultCacheManager().removeFile(cacheKey);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<void> cacheWeatherData(WeatherData weatherData) async {
    final jsonString = json.encode(weatherData.toJson());
    await DefaultCacheManager().putFile(cacheKey, utf8.encode(jsonString));

    final timestamp = DateTime.now().toIso8601String();
    await DefaultCacheManager().putFile(timestampKey, utf8.encode(timestamp));
  }

  static bool _isCacheExpired(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp).inMinutes;
    // Cache is considered expired after 5 minutes
    return difference >= 5;
  }
}