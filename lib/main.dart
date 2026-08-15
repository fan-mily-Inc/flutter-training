import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _yumemiWeather = YumemiWeather();
  String? _weatherCondition;

  void _reloadWeather() {
    setState(() {
      _weatherCondition = _yumemiWeather.fetchSimpleWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: switch (_weatherCondition) {
                  final condition? => SvgPicture.asset('assets/$condition.svg'),
                  null => const Placeholder(),
                },
              ),
              const SizedBox(height: 80),
              TextButton(
                onPressed: _reloadWeather,
                child: const Text('Reload'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
