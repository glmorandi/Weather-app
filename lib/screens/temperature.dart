import 'package:flutter/material.dart';

class TemperaturePage extends StatelessWidget {
  final String temperature;

  const TemperaturePage({super.key, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Alert'),
      ),
      body: Center(
        child: Text(
          'Current temperature: $temperature°C',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
