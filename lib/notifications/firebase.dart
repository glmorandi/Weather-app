import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:weather/screens/home_screen.dart';
import 'package:weather/screens/warning_screen.dart';

class FireBaseManager {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    try {
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      print('User: ${settings.authorizationStatus}');

      String? userToken = await _firebaseMessaging.getToken();
      print('Token: $userToken');

      configureNotificationHandling();
    } catch (e) {
      print('Error: $e');
    }
  }

  void configureNotificationHandling() {
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      processNotification(message);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      processNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      processNotification(message);
    });
  }

  void processNotification(RemoteMessage? message) {
    if (message != null) {
      print(message.data);
        navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => WarningScreen(message: message)));
    }
  }
}
