import "package:geolocator/geolocator.dart";
import "package:weather/helper/api_service.dart";
import "package:weather/helper/cache_manager.dart";
import "package:weather/helper/location_manager.dart";
import "package:weather/model/weather_data.dart";

class WeatherService{
  static Future<WeatherData> getWeatherData() async {
    WeatherData? weather = await CacheManager.getCachedWeatherData();

    if(weather == null){
      // No cache found so we make a request
      
      Position? current = await LocationManager.getCurrentLocation();
      
      weather = await ApiService(current!.latitude, current.longitude).fetchWeatherData();

      await CacheManager.cacheWeatherData(weather);
    }
  
    return weather;
  }
}