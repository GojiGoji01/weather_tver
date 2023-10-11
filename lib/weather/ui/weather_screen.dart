import 'package:bless_clicker/weather/data/models/weather.dart';
import 'package:bless_clicker/weather/data/weather_api.dart';
import 'package:flutter/material.dart';

enum DegreeUnit {
  celsius('°C'),
  fahrenheit('°F');

  const DegreeUnit(this.sign);

  final String sign;
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Weather? _weather;
  String _selectedCity = 'London';
  DegreeUnit _selectedUnit = DegreeUnit.celsius;
  final List<String> cities = [
    'London',
    'Tver',
    'Paris',
    'Saint-P',
    'Tokyo',
    'USA',
  ];
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

  bool get isDaytime => _weather?.isDaytime ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                isDaytime() ? 'assets/dayset.jpg' : 'assets/nightset.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            if (_weather != null)
              Align(
                alignment: const Alignment(0, -0.2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.sunny,
                      size: 44,
                      color: Colors.yellow,
                    ),
                    Text(
                      _selectedUnit == DegreeUnit.celsius
                          ? _weather!.temp.toStringAsFixed(1)
                          : _weather!.tempFahrenheit.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 54,
                        color: Color.fromARGB(255, 82, 203, 21),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    DropdownButton<DegreeUnit>(
                      value: _selectedUnit,
                      icon: const SizedBox.shrink(),
                      underline: const SizedBox.shrink(),
                      dropdownColor: Colors.blue[200]?.withOpacity(0.3),
                      focusColor: Color.fromARGB(0, 117, 193, 51),
                      elevation: 0,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 143, 187, 41),
                      ),
                      items: DegreeUnit.values.map((unit) {
                        return DropdownMenuItem<DegreeUnit>(
                          value: unit,
                          child: Text(unit.sign),
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
                dropdownColor: Colors.blue[200]?.withOpacity(0.2),
                focusColor: Color.fromARGB(0, 170, 198, 46),
                elevation: 0,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 124, 124, 32),
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
