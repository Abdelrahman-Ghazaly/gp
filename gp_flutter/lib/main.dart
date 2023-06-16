import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/services/injection_container.dart';
import 'package:gp_flutter/core/theme/theme.dart';
import 'package:gp_flutter/core/utils/app_router.dart';
import 'package:gp_flutter/features/auction/presentation/bloc/bid_auction_bloc/bloc/bid_auction_bloc_bloc.dart';
import 'package:gp_flutter/features/auction/presentation/bloc/get_all_auctions_bloc/all_auctions_bloc.dart';
import 'package:gp_flutter/features/auction/presentation/bloc/get_auction_by_id/get_auction_by_id_bloc.dart';
import 'package:gp_flutter/features/auction/presentation/bloc/search_auctions_bloc/search_auctions_bloc.dart';
import 'package:gp_flutter/features/auction/presentation/bloc/upload_auction_bloc/upload_auction_bloc.dart';
import 'package:gp_flutter/features/authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart';
import 'package:gp_flutter/features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/create_conversation_bloc/create_conversation_bloc.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/get_conversation_bloc/get_conversation_bloc.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/get_messages_bloc/get_messages_bloc.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/get_user_name_bloc/get_user_name_bloc.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/send_message_bloc/send_message_bloc.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/delete_product_bloc/delete_product_bloc.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/e_commerce_user_bloc/e_commerce_user_bloc.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/product_view_bloc/product_view_bloc.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/report_furniture_bloc/report_furniture_bloc.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/search_bloc/search_furniture_bloc.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/upload_product_bloc/upload_product_bloc.dart';

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
        BlocProvider(create: (BuildContext context) => sl<LogInBloc>()),
        BlocProvider(create: (BuildContext context) => sl<SignUpBloc>()),
        BlocProvider(create: (BuildContext context) => sl<DeleteProductBloc>()),
        BlocProvider(create: (BuildContext context) => sl<HomeBloc>()),
        BlocProvider(create: (BuildContext context) => sl<ECommerceUserBloc>()),
        BlocProvider(create: (BuildContext context) => sl<FavoriteBloc>()),
        BlocProvider(create: (BuildContext context) => sl<ProductViewBloc>()),
        BlocProvider(create: (BuildContext context) => sl<SearchBloc>()),
        BlocProvider(create: (BuildContext context) => sl<UploadProductBloc>()),
        BlocProvider(create: (BuildContext context) => sl<ReportFurnitureBloc>()),
        BlocProvider(create: (BuildContext context) => sl<GetAuctionByIdBloc>()),
        BlocProvider(create: (BuildContext context) => sl<AllAuctionsBloc>()),
        BlocProvider(create: (BuildContext context) => sl<SearchAuctionsBloc>()),
        BlocProvider(create: (BuildContext context) => sl<BidAuctionBloc>()),
        BlocProvider(create: (BuildContext context) => sl<GetConversationsBloc>()),
        BlocProvider(create: (BuildContext context) => sl<CreateConversationBloc>()),
        BlocProvider(create: (BuildContext context) => sl<GetMessagesBloc>()),
        BlocProvider(create: (BuildContext context) => sl<SendMessageBloc>()),
        BlocProvider(create: (BuildContext context) => sl<GetUserNameBloc>()),
        BlocProvider(create: (BuildContext context) => sl<UploadAuctionBloc>()),
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
