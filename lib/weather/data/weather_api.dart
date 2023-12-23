import 'dart:convert';

import 'package:bless_clicker/weather/data/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  Future<List<Humidity>> getWeatherPerDays(String city, int days) async {
    final response = await http.get(Uri.parse(
      // итерполирую дэйс и указваю что дейс будет равно дэйсам чтоб чтоб они начинались с 1
      'http://api.weatherapi.com/v1/forecast.json?key=06efce47c8ea4d30a2b85828233009&q=London&days=$days&aqi=no&alerts=no',
    ));

    final jsonMap = jsonDecode(response.body);
    final forecastData = jsonMap['forecast']['forecastday'] as List<dynamic>;

    return forecastData.map((day) {
      return Humidity.fromJson(day);
    }).toList();
  }

  Future<Weather> getCurrentWeather(String city) async {
    // final uri = Uri.parse(
    //   'http://api.weatherapi.com/v1/current.json',
    // );
    // final params = uri..queryParameters = { };

    final response = await http.get(Uri.parse(
      'http://api.weatherapi.com/v1/current.json?key=06efce47c8ea4d30a2b85828233009&q=$city&days=1',
    ));
    final jsonMap = jsonDecode(response.body);

    return Weather.fromJson(jsonMap);
  }
}

class Humidity {
  const Humidity({
    required this.date,
    required this.value,
  });

  final DateTime date;
  final double value;

  factory Humidity.fromJson(Map<String, dynamic> json) => Humidity(
      date: DateTime.parse(json['date']),
      value: json['day']['avghumidity'] as double);
}

class Cloudy {
  const Cloudy({
    required this.date,
    required this.cloud,
  });
  final DateTime date;
  final double cloud;

  factory Cloudy.formJson(Map<String, dynamic> json) => Cloudy(
      date: DateTime.parse(json['hour']),
      cloud: json['hour']['cloud'] as double);
}
