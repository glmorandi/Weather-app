import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:weather/model/weather_data.dart';
import 'package:weather/screens/high_temperature.dart';
import 'package:weather/screens/temperature.dart';
import 'package:weather/screens/home_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();



const AndroidNotificationDetails generalNotificationChannel =
    AndroidNotificationDetails(
  'general_channel',
  'General Notifications',
  channelDescription: 'Channel for general notifications',
  importance: Importance.max,
  priority: Priority.max,
);

const AndroidNotificationDetails weatherNotificationChannel =
    AndroidNotificationDetails(
  'weather_channel',
  'Weather Updates',
  channelDescription: 'Channel for weather update notifications',
  importance: Importance.low,
  priority: Priority.high,
);

const InitializationSettings initializationSettings =
    InitializationSettings(
  android: AndroidInitializationSettings('@mipmap/ic_launcher'),
);

Future<void> initializeNotifications() async {
  final bool? result = await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  if (result != null && result) {
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification
    );
  } else {
    print("Permission for notifications denied");
  }
}

void onSelectNotification(NotificationResponse notificationResponse) async {
  final payload = notificationResponse.payload;
  if (payload != null) {
    print("Notification payload: $payload");
    if (payload.contains('HighTemperature')) {
      final temperature = payload.replaceAll('HighTemperature: ', ''); // Extrai a temperatura do payload
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => HighTemperaturePage(temperature: temperature)),
      );
    } else {
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => TemperaturePage(temperature: payload)),
      );
    }
  }
}

Future<void> showNotification(WeatherData weatherData) async {
  await flutterLocalNotificationsPlugin.show(
    0,
    'Weather Update',
    'Current temperature: ${weatherData.current.temperature}°C',
    const NotificationDetails(android: weatherNotificationChannel),
    payload: weatherData.current.temperature.toString(),
  );
}

Future<void> showWarning(WeatherData weatherData) async {
  await flutterLocalNotificationsPlugin.show(
    0,
    'Temperature Warning',
    'Current temperature: ${weatherData.current.temperature}°C',
    const NotificationDetails(android: generalNotificationChannel),
    payload: 'HighTemperature: ${weatherData.current.temperature}',
  );
}


Future<void> doNotification(WeatherData weatherData) async {
if(weatherData.current.temperature > 1){
  print("High Temperature");
  await showWarning(weatherData);
}
else{
  print("Normal Temperature");
  showNotification(weatherData);
}
}