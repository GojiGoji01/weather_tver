import 'dart:convert';

import 'package:bless_clicker/weather/data/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  Future<Weather> getCurrentWeather(String city, String unit) async {
    // final uri = Uri.parse(
    //   'http://api.weatherapi.com/v1/current.json',
    // );
    // final params = uri..queryParameters = { };

    final response = await http.get(Uri.parse(
      'http://api.weatherapi.com/v1/current.json?key=06efce47c8ea4d30a2b85828233009&q=$city&unit=$unit',
    ));
    final jsonMap = jsonDecode(response.body);
    return Weather.fromJson(jsonMap);
  }
}
