import 'package:bless_clicker/weather/data/weather_api.dart';
import 'package:flutter/material.dart';

class HumidityScreen extends StatefulWidget {
  final String city;

  HumidityScreen({required this.city});

  @override
  _HumidityScreenState createState() => _HumidityScreenState();
}

class _HumidityScreenState extends State<HumidityScreen>
    with TickerProviderStateMixin {
  late final _controller = TabController(length: 3, vsync: this);
  List<Humidity> _weathers = [];

  Future<void> _getWeather(int days) async {
    final api = WeatherApi();
    try {
      final humidity = await api.getWeatherPerDays(widget.city, days);

      setState(() {
        _weathers = humidity;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _controller.addListener(() {
      final days = switch (_controller.index) {
        0 => 1,
        1 => 2,
        2 => 3,
        _ => 1,
      };
      _getWeather(days);
    });

    _getWeather(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Durations.short3,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Color.fromARGB(225, 45, 65, 58),
          bottom: TabBar(
              overlayColor: const MaterialStatePropertyAll(
                  Color.fromARGB(255, 27, 195, 69)),
              controller: _controller,
              indicatorColor: Colors.black,
              labelColor: const Color.fromARGB(255, 202, 219, 203),
              labelStyle: const TextStyle(
                overflow: TextOverflow.fade,
              ),
              tabs: const [
                Tab(
                  text: '1 день',
                ),
                Tab(text: '2 дня'),
                Tab(text: '3 дня'),
              ]),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/humidity_pic.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        body: TabBarView(controller: _controller, children: [
          _buildTab(),
          _buildTab(),
          _buildTab(),
        ]),
      ),
    );
  }

  Widget _buildTab() {
    // Здесь вы можете использовать ListView.builder для отображения данных внутри каждого таба
    return Container(
      color: Colors.green.shade100,
      child: ListView.builder(
        itemCount: _weathers.length,
        itemBuilder: (context, index) {
          final humidity = _weathers[index];

          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            leading: Icon(Icons.invert_colors),
            title: Text(
              humidity.value.toString(),
            ),
            subtitle: Text(
              humidity.date.toString(),
            ),
          );
        },
      ),
    );
  }
}
