import 'package:bless_clicker/weather/data/models/weather.dart';
import 'package:bless_clicker/weather/data/weather_api.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Weather? _weather;
  String _selectedCity = 'London';
  final List<String> cities = ['London', 'Tver', 'Paris', 'Saint-P', 'Tokyo'];

  Future<void> _getWeather() async {
    final api = WeatherApi();
    try {
      final weather = await api.getCurrentWeather(_selectedCity);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[100],
        child: Stack(
          children: [
            DropdownButton<String>(
              value: _selectedCity,
              items: cities.map((city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCity = value!;
                  _getWeather();
                });
              },
            ),
            Center(
              child: Text(
                _weather?.temp.toStringAsFixed(1) ?? '',
                style: TextStyle(
                  fontSize: 54,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, -0.8),
              child: Text(
                _weather?.city ?? '',
                style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
