import 'dart:async';

import 'package:bless_clicker/number_section.dart';
import 'package:bless_clicker/weather/ui/weather_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'KONKRETIKA',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const WeatherScreen());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _loginController = TextEditingController(text: '+79111111111');
  final _passwordController = TextEditingController(text: 'qwe123');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _loginController,
                decoration: InputDecoration(hintText: 'Enter login..'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                obscuringCharacter: '+',
                decoration: InputDecoration(hintText: 'Enter password..'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_loginController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Заполните пустые поля!'),
                    ));
                  } else {
                    if (_loginController.text == '+79111111111' &&
                        _passwordController.text == 'qwe123') {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NumbersScreen()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Неверный логин или пароль!'),
                      ));
                    }
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
