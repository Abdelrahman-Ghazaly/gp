import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/app_constants/app_values.dart';
import 'package:gp_flutter/injection_container.dart';

import 'core/theme/theme.dart';
import 'features/e_commerce/presentation/bloc/e_commerce_bloc.dart';
import 'features/e_commerce/presentation/screens/home_screen.dart';

late String base64String;
void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GP E-Commerce',
      debugShowCheckedModeBanner: false,
      theme: kLightThemeData(),
      home: BlocProvider(
        create: (_) => serviceLocator<ECommerceBloc>()
          ..add(
            const GetPopularFurniturebyCategoryEvent(
              category: Category.lamp,
            ),
          ),
        child: const HomeScreen(),
      ),
    );
  }
}
