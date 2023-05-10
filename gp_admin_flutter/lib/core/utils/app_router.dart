import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_admin_flutter/features/authentication/presentation/screens/log_in_screen.dart';

import '../common_widgets/common_widgets.dart';

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const LogInScreen();
      },
      routes: const [
        /*  GoRoute(
            path: "auction_details_screen",
            builder: (BuildContext context, GoRouterState state) {
              final auctionId = state.queryParams['auction_id'];
              return AuctionDetailsScreen(
                auctionId: auctionId!,
              );
            }),
        GoRoute(
            path: "auction_search_screen",
            builder: (BuildContext context, GoRouterState state) {
              final auctionId = state.queryParams['auction_search'];
              return AuctionSearchScreen(
                auctionSearch: auctionId!,
              );
            }),
        GoRoute(
            path: "add_auction_screen",
            builder: (BuildContext context, GoRouterState state) {
              return const AddAuctionScreen();
            }),*/
      ])
]);
