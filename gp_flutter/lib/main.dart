import 'package:flutter/material.dart';
import 'package:gp_flutter/core/theme/theme.dart';

import 'core/utils/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GP E-Commerce',
      debugShowCheckedModeBanner: false,
      theme: kLightThemeData(),
      routerConfig: router,
    );
  }
}
