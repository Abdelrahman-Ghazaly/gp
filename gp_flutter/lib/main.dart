import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/theme/theme.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/e_commerce_bloc.dart';
import 'package:gp_flutter/injection_container.dart';

import 'core/utils/app_router.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<ECommerceBloc>(),
      child: MaterialApp.router(
        title: 'GP E-Commerce',
        debugShowCheckedModeBanner: false,
        theme: kLightThemeData(),
        routerConfig: router,
      ),
    );
  }
}
