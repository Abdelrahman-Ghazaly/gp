import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_admin_flutter/features/authentication/presentation/screens/log_in_screen.dart';

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const LogInScreen();
      },
      routes: const [])
]);
