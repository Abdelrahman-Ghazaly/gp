import 'package:flutter/material.dart';
import 'package:gp_flutter/core/theme/theme.dart';
import 'package:gp_flutter/features/e_commerce/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GP E-Commerce',
      debugShowCheckedModeBanner: false,
      theme: kLightThemeData,
      home: const HomeScreen(),
    );
  }
}
