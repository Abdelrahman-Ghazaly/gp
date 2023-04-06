import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_flutter/features/auction/presentation/screens/auction_details_screen.dart';
import 'package:gp_flutter/features/auction/presentation/screens/auction_screen.dart';

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const AuctionScreen();
      },
      routes: [
        GoRoute(
            path: "auction_details_screen",
            builder: (BuildContext context, GoRouterState state) {
              return const AuctionDetailsScreen();
            }),
      ])
]);
