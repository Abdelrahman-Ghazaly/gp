import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/create_conversation_bloc/create_conversation_bloc.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/get_conversation_bloc/get_conversation_bloc.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/get_messages_bloc/get_messages_bloc.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/get_user_name_bloc/get_user_name_bloc.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/send_message_bloc/send_message_bloc.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/report_furniture_bloc/report_furniture_bloc.dart';
import 'features/auction/presentation/bloc/bid_auction_bloc/bloc/bid_auction_bloc_bloc.dart';
import 'features/e_commerce/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'features/authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart';
import 'features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'features/e_commerce/presentation/bloc/delete_product_bloc/delete_product_bloc.dart';
import 'features/e_commerce/presentation/bloc/e_commerce_user_bloc/e_commerce_user_bloc.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
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
        BlocProvider(create: (context) => sl<ECommerceUserBloc>()),
        BlocProvider(create: (context) => sl<FavoriteBloc>()),
        BlocProvider(create: (context) => sl<ProductViewBloc>()),
        BlocProvider(create: (context) => sl<SearchBloc>()),
        BlocProvider(create: (context) => sl<UploadProductBloc>()),
        BlocProvider(create: (context) => sl<ReportFurnitureBloc>()),
        BlocProvider(create: (context) => sl<GetAuctionByIdBloc>()),
        BlocProvider(create: (context) => sl<AllAuctionsBloc>()),
        BlocProvider(create: (context) => sl<SearchAuctionsBloc>()),
        BlocProvider(create: (context) => sl<BidAuctionBloc>()),
        BlocProvider(create: (context) => sl<GetConversationsBloc>()),
        BlocProvider(create: (context) => sl<CreateConversationBloc>()),
        BlocProvider(create: (context) => sl<GetMessagesBloc>()),
        BlocProvider(create: (context) => sl<SendMessageBloc>()),
        BlocProvider(create: (context) => sl<GetUserNameBloc>()),
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
