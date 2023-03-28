import 'package:flutter/material.dart';
import 'package:gp_flutter/core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GP E-commmerce',
      debugShowCheckedModeBanner: false,
      theme: kLightThemeData,
      home: const Scaffold(
        body: Center(
          child: Text('Flutter Demo Home Page'),
        ),
      ),
    );
  }
}
