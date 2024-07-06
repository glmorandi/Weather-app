import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/helper/location_manager.dart';
import 'weather_screen.dart';
import 'package:weather/notifications/local.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Position?>? _locationFuture;

  @override
  void initState() {
    super.initState();
    _locationFuture = LocationManager.getCurrentLocation();
    initializeNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Weather App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
        ),
        body: FutureBuilder<Position?>(
          future: _locationFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return _buildErrorContent();
            } else if (snapshot.hasData) {
              final position = snapshot.data!;
              return const WeatherScreen();
            } else {
              return _buildErrorContent();
            }
          },
        ),
      ),
    );
  }

  Widget _buildErrorContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 100),
          const SizedBox(height: 16),
          const Text(
            'Failed to get location data.',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _locationFuture = LocationManager.getCurrentLocation();
              });
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
