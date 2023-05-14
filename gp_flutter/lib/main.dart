import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/e_commerce/presentation/bloc/user_product_bloc/user_product_bloc.dart';
import 'features/authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart';
import 'features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'features/e_commerce/presentation/bloc/delete_product_bloc/delete_product_bloc.dart';
import 'features/e_commerce/presentation/bloc/home_bloc/home_bloc.dart';
import 'features/e_commerce/presentation/bloc/product_view_bloc/product_view_bloc.dart';
import 'features/e_commerce/presentation/bloc/search_bloc/search_furniture_bloc.dart';
import 'features/e_commerce/presentation/bloc/upload_product_bloc/upload_product_bloc.dart';

import 'core/services/injection_container.dart';
import 'core/theme/theme.dart';
import 'core/utils/app_router.dart';
import 'features/auction/presentation/bloc/get_all_auctions_bloc/all_auctions_bloc.dart';
import 'features/auction/presentation/bloc/get_auction_by_id/get_auction_by_id_bloc.dart';
import 'features/auction/presentation/bloc/search_auctions_bloc/search_auctions_bloc.dart';

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
        BlocProvider(create: (context) => sl<LogInBloc>()),
        BlocProvider(create: (context) => sl<SignUpBloc>()),
        BlocProvider(create: (context) => sl<DeleteProductBloc>()),
        BlocProvider(create: (context) => sl<HomeBloc>()),
        BlocProvider(create: (context) => sl<UserProductBloc>()),
        BlocProvider(create: (context) => sl<ProductViewBloc>()),
        BlocProvider(create: (context) => sl<SearchBloc>()),
        BlocProvider(create: (context) => sl<UploadProductBloc>()),
        BlocProvider(create: (context) => sl<GetAuctionByIdBloc>()),
        BlocProvider(create: (context) => sl<AllAuctionsBloc>()),
        BlocProvider(create: (context) => sl<SearchAuctionsBloc>()),
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
