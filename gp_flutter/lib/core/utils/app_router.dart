import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auction/presentation/screens/auction_details_screen.dart';
import '../../features/auction/presentation/screens/auction_search_screen.dart';
import '../../features/authentication/presentation/screens/log_in_screen.dart';
import '../common_widgets/common_widgets.dart';

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const BottomNavBar();
      },
      routes: [
        GoRoute(
            path: 'login_screen',
            builder: (BuildContext context, GoRouterState state) {
              return const LogInScreen();
            }),
        GoRoute(
          path: 'auction_details_screen',
          builder: (BuildContext context, GoRouterState state) {
            final String? auctionId = state.queryParameters['auction_id'];
            return AuctionDetailsScreen(
              auctionId: auctionId!,
            );
          },
        ),
        GoRoute(
            path: 'auction_search_screen',
            builder: (BuildContext context, GoRouterState state) {
              final String? auctionId = state.queryParameters['auction_search'];
              return AuctionSearchScreen(
                auctionSearch: auctionId!,
              );
            }),
      ]),
]);
