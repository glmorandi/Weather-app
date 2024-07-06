import 'package:flutter/material.dart';

class HighTemperaturePage extends StatelessWidget {
  final String temperature;

  const HighTemperaturePage({super.key, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('High Temperature Alert'),
      ),
      body: Center(
        child: Text(
          'High temperature: $temperature°C',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
