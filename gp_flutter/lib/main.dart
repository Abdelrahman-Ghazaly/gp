import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/theme/theme.dart';
import 'features/e_commerce/presentation/screens/home_screen.dart';

late String base64String;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  base64String = await _getImage();
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

Future<String> _getImage() async {
  final ByteData byteData = await rootBundle.load('assets/images.jpg');
  Uint8List unit8list = byteData.buffer.asUint8List();
  String base64String = base64.encode(unit8list);
  return base64String;
}
