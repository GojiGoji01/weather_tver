import 'package:flutter/material.dart';

class CloudyScreen extends StatefulWidget {
  final double cloud;
  CloudyScreen(this.cloud);

  @override
  _CloudyScreenState createState() => _CloudyScreenState();
}

class _CloudyScreenState extends State<CloudyScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Облачность"),
          bottom: const TabBar(tabs: [
            Tab(text: '1 день'),
            Tab(text: '7 дней'),
            Tab(text: '14 дней'),
          ]),
        ),
        body: TabBarView(children: [
          Container(
            color: Colors.greenAccent,
            child: const Tab(text: '1 день'),
          ),
          Container(
            color: Colors.orangeAccent,
            child: const Tab(text: '7 дней'),
          ),
          Container(
            color: Colors.grey,
            child: const Tab(text: '14 дней'),
          ),
        ]),
      ),
    );
  }
}
