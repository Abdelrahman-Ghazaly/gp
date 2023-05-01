import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/theme.dart';
import 'features/auction/presentation/bloc/get_all_auctions_bloc/all_auctions_bloc.dart';
import 'features/auction/presentation/bloc/get_auction_by_id/get_auction_by_id_bloc.dart';
import 'features/e_commerce/presentation/bloc/e_commerce_bloc.dart';
import 'core/theme/theme.dart';
import 'features/e_commerce/presentation/bloc/e_commerce_bloc.dart';
import 'core/services/injection_container.dart';

import 'core/utils/app_router.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ECommerceBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<GetAuctionByIdBloc>(),
        ),
        BlocProvider(
            create: (context) =>
                sl<AllAuctionsBloc>()..add(GetAuctionProductsEvent())),
      ],
      child: MaterialApp.router(
        title: 'GP E-Commerce',
        debugShowCheckedModeBanner: false,
        theme: kLightThemeData(),
        routerConfig: router,
      ),
    );
  }
}
