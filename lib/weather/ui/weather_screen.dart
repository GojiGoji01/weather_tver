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
  String _selectedUnit = '°C';
  final List<String> cities = ['London', 'Tver', 'Paris', 'Saint-P', 'Tokyo'];
  final List<String> units = ['°C', '°F'];
  Future<void> _getWeather() async {
    final api = WeatherApi();
    try {
      final weather = await api.getCurrentWeather(
        _selectedCity,
        _selectedUnit,
      );

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
        color: Color.fromARGB(255, 62, 68, 74),
        child: Stack(
          children: [
            if (_weather != null)
              Align(
                alignment: const Alignment(0, -0.2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.sunny_snowing,
                      size: 44,
                      color: Colors.yellow,
                    ),
                    Text(
                      _selectedUnit == '°C'
                          ? '${_weather!.temp.toStringAsFixed(1)}'
                          : '${_weather!.tempFahrenheit.toStringAsFixed(1)}',
                      style: const TextStyle(
                        fontSize: 54,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 20),
                    DropdownButton<String>(
                      value: _selectedUnit,
                      icon: const SizedBox.shrink(),
                      underline: const SizedBox.shrink(),
                      dropdownColor: Colors.blue[200]?.withOpacity(0.9),
                      focusColor: Colors.transparent,
                      elevation: 0,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      items: units.map((unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedUnit = value!;
                          _getWeather();
                        });
                      },
                    ),
                  ],
                ),
              ),
            Align(
              alignment: const Alignment(0, -0.5),
              child: DropdownButton<String>(
                value: _selectedCity,
                icon: const SizedBox.shrink(),
                underline: const SizedBox.shrink(),
                dropdownColor: Colors.blue[200]?.withOpacity(0.9),
                focusColor: Colors.transparent,
                elevation: 0,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
