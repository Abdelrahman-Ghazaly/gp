import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_admin_flutter/features/auction/presentation/bloc/get_all_auctions_bloc/all_auctions_bloc.dart';
import 'package:gp_admin_flutter/features/reports/presentation/bloc/accept_refuse_report_bloc/request_report_bloc.dart';
import 'package:gp_admin_flutter/features/reports/presentation/bloc/get_all_reports_bloc/all_reports_bloc.dart';

import 'core/services/injection_container.dart';
import 'core/theme/light_theme.dart';
import 'core/utils/app_router.dart';
import 'features/auction/presentation/bloc/request_austion_bloc/request_auction_bloc.dart';
import 'features/authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart';

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
        BlocProvider(create: (context) => sl<AllAuctionsBloc>()),
        BlocProvider(create: (context) => sl<RequestAuctionBloc>()),
        BlocProvider(create: (context) => sl<AllReportsBloc>()),
        BlocProvider(create: (context) => sl<RequestReportsBloc>())
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
