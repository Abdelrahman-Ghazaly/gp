import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_flutter/core/common_widgets/common_widgets.dart';
import 'package:gp_flutter/features/auction/presentation/screens/add_auction_screen.dart';
import 'package:gp_flutter/features/auction/presentation/screens/auction_details_screen.dart';

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
        GoRoute(
            path: "add_auction_screen",
            builder: (BuildContext context, GoRouterState state) {
              return const AddAuctionScreen();
            }),
      ])
]);
