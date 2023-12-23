import 'package:bless_clicker/weather/data/models/weather.dart';
import 'package:bless_clicker/weather/data/weather_api.dart';
import 'package:flutter/material.dart';
import 'package:bless_clicker/weather/ui/cloudy_screen.dart';
import 'package:bless_clicker/weather/ui/humidity_screen.dart';

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
    'Moscow',
    'Tver',
    'Paris',
    'Saint-P',
    'Tokyo',
    'USA',
  ];

  @override
  void initState() {
    super.initState(); // 1 выносишь скрины в отдельные файлы (ВЫПОЛНЕНО)
    // 2. в классе состаяния экрана иницилизируешь переменную _weathers, пустым масивом = [] ,
    //3. создаешь функцию getWetherPerDays в которой делаешь вызов апишки из класса апи , распарсит данные ,
    //4. через set state  кладешь в  _weathers полученный масив с погодой из апи
    //5. в методе build на каждый таб добавить ListView.builder которой обрабатывает _weathers
    //6. при смене tab найти callback на смену таба
    _getWeather();
  }

  Future<void> _getWeather() async {
    final api = WeatherApi();
    try {
      final selectedCity = _selectedCity;
      final weather = await api.getCurrentWeather(selectedCity);

      setState(() {
        _weather = weather;
        _selectedCity = selectedCity;
      });
    } catch (e) {
      print(e);
    }
  }

  bool get isDaytime => _weather?.isDaytime ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                isDaytime ? 'assets/dayset.jpg' : 'assets/nightset.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            if (_weather != null)
              Align(
                alignment: const Alignment(0, 0.45),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CloudyScreen(_weather?.cloud ?? 0),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.cloud_outlined,
                        size: 24,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Облачность ${_weather?.cloud ?? 0}%',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            Align(
              alignment: const Alignment(0, 0.25),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HumidityScreen(
                        city: _selectedCity,
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.invert_colors,
                      size: 24,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Влажность: ${_weather?.humidity ?? 0}%',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                        ? _weather?.temp?.toStringAsFixed(1) ?? ''
                        : _weather?.tempFahrenheit?.toStringAsFixed(1)
                            as String,
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
