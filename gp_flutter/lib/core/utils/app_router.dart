import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auction/presentation/screens/auction_details_screen.dart';
import '../common_widgets/common_widgets.dart';

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const BottomNavBar();
      },
      routes: [
        GoRoute(
            path: "auction_details_screen",
            builder: (BuildContext context, GoRouterState state) {
              return const AuctionDetailsScreen();
            }),
      ])
]);
