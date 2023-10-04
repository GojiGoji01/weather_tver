import 'dart:async';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int counter = 0;
  bool isIncrementing = false;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void _startIncrement() {
    isIncrementing = true;
    _incrementCounter();
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (isIncrementing) {
        _incrementCounter();
      } else {
        timer.cancel();
      }
    });
  }

  void _stopIncrement() {
    isIncrementing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('TAP: $counter'),
            const SizedBox(height: 16),
            GestureDetector(
                onTap: _incrementCounter,
                onLongPress: _startIncrement,
                onLongPressUp: _stopIncrement,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 30,
                  child: IconButton(
                    onPressed: () {
                      _incrementCounter();
                    },
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
