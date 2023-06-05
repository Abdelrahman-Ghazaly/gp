import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gp_flutter/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:gp_flutter/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:gp_flutter/features/chat/domain/repositories/chat_repository.dart';
import 'package:gp_flutter/features/chat/domain/usecases/create_conversation.dart';
import 'package:gp_flutter/features/chat/domain/usecases/get_messages.dart';
import 'package:gp_flutter/features/chat/domain/usecases/get_user_name.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/create_conversation_bloc/create_conversation_bloc.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/get_user_name_bloc/get_user_name_bloc.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/report_furniture_bloc/report_furniture_bloc.dart';
import '../../features/chat/domain/usecases/get_conversation.dart';
import '../../features/chat/domain/usecases/send_message.dart';
import '../../features/chat/presentation/bloc/get_conversation_bloc/get_conversation_bloc.dart';
import '../../features/chat/presentation/bloc/get_messages_bloc/get_messages_bloc.dart';
import '../../features/chat/presentation/bloc/send_message_bloc/send_message_bloc.dart';
import '../../features/e_commerce/domain/use_cases/favorite/add_favorite.dart';
import '../../features/e_commerce/domain/use_cases/favorite/delete_favorite.dart';
import '../../features/e_commerce/domain/use_cases/favorite/get_favorite.dart';
import '../../features/auction/domain/usecases/bid_auction_usecase.dart';
import '../../features/auction/presentation/bloc/bid_auction_bloc/bloc/bid_auction_bloc_bloc.dart';
import '../../features/authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart';
import '../../features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import '../../features/e_commerce/domain/use_cases/product/report_furniture.dart';
import '../../features/e_commerce/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import '../../features/auction/data/data_source/auction_reomte_data_source.dart';
import '../../features/auction/data/repository/auction_repository.dart';
import '../../features/auction/domain/repositories/base_auction_repository.dart';
import '../../features/auction/domain/usecases/delete_auction_usecase.dart';
import '../../features/auction/domain/usecases/get_auction_products_search_result_usecase.dart';
import '../../features/auction/domain/usecases/get_auction_products_usecase.dart';
import '../../features/auction/domain/usecases/upload_auction_product_usecase.dart';
import '../../features/auction/domain/usecases/view_auction_data.dart';
import '../../features/auction/presentation/bloc/get_all_auctions_bloc/all_auctions_bloc.dart';
import '../../features/auction/presentation/bloc/get_auction_by_id/get_auction_by_id_bloc.dart';
import '../../features/auction/presentation/bloc/search_auctions_bloc/search_auctions_bloc.dart';
import '../../features/authentication/data/data_sources/authentication_remote_data_source.dart';
import '../../features/authentication/data/repositories/authenitcation_repository_impl.dart';
import '../../features/authentication/domain/repositories/authentication_repository.dart';
import '../../features/authentication/domain/usecases/log_in.dart';
import '../../features/authentication/domain/usecases/sign_up.dart';
import '../../features/e_commerce/data/data_sources/furniture_remote_data_source.dart';
import '../../features/e_commerce/data/repositories/e_commerce_repository_impl.dart';
import '../../features/e_commerce/domain/repositories/e_commerce_repository.dart';
import '../../features/e_commerce/domain/use_cases/product/delete_product.dart';
import '../../features/e_commerce/domain/use_cases/get_furniture/get_furniture_from_id.dart';
import '../../features/e_commerce/domain/use_cases/get_furniture/get_furniture_from_search.dart';
import '../../features/e_commerce/domain/use_cases/get_furniture/get_popular_furniture_by_category.dart';
import '../../features/e_commerce/domain/use_cases/get_user_data.dart';
import '../../features/e_commerce/domain/use_cases/product/upload_furniture.dart';
import '../../features/e_commerce/presentation/bloc/delete_product_bloc/delete_product_bloc.dart';
import '../../features/e_commerce/presentation/bloc/e_commerce_user_bloc/e_commerce_user_bloc.dart';
import '../../features/e_commerce/presentation/bloc/home_bloc/home_bloc.dart';
import '../../features/e_commerce/presentation/bloc/product_view_bloc/product_view_bloc.dart';
import '../../features/e_commerce/presentation/bloc/search_bloc/search_furniture_bloc.dart';
import '../../features/e_commerce/presentation/bloc/upload_product_bloc/upload_product_bloc.dart';

final sl = GetIt.instance;

void init() {
  initBloc();
  initFeatures();
  initRepository();
  initDataSources();
  initExternalPackages();
}

void initBloc() {
  sl.registerFactory(() => DeleteProductBloc(deleteFurniture: sl()));
  sl.registerFactory(() => HomeBloc(getPopularFurniturebyCategory: sl()));
  sl.registerFactory(() => ProductViewBloc(getFurnitureFromId: sl()));
  sl.registerFactory(() => SearchBloc(getFurnitureFromSearch: sl()));
  sl.registerFactory(() => UploadProductBloc(uploadFurniture: sl()));
  sl.registerFactory(() => ECommerceUserBloc(getUserData: sl()));
  sl.registerFactory(() => ReportFurnitureBloc(reportFurniture: sl()));
  sl.registerFactory(() => FavoriteBloc(
        addFavorite: sl(),
        deleteFavorite: sl(),
        getFavorite: sl(),
      ));

  sl.registerFactory(() => SignUpBloc(signUp: sl()));
  sl.registerFactory(() => LogInBloc(logIn: sl()));

  sl.registerFactory(() => AllAuctionsBloc(sl()));
  sl.registerFactory(() => GetAuctionByIdBloc(sl()));
  sl.registerFactory(() => SearchAuctionsBloc(sl()));
  sl.registerFactory(() => BidAuctionBloc(sl()));

  sl.registerFactory(() => CreateConversationBloc(createConversation: sl()));
  sl.registerFactory(() => GetConversationsBloc(getConversation: sl()));
  sl.registerFactory(() => SendMessageBloc(sendMessage: sl()));
  sl.registerFactory(() => GetMessagesBloc(getMessages: sl()));
  sl.registerFactory(() => GetUserNameBloc(getUserName: sl()));
}

void initFeatures() {
  sl.registerLazySingleton(() => LogIn(repository: sl()));
  sl.registerLazySingleton(() => SignUp(repository: sl()));

  sl.registerLazySingleton(() => GetFurnitureFromId(repository: sl()));
  sl.registerLazySingleton(() => GetFurnitureFromSearch(repository: sl()));
  sl.registerLazySingleton(() => GetUserData(repository: sl()));
  sl.registerLazySingleton(
      () => GetPopularFurniturebyCategory(repository: sl()));
  sl.registerLazySingleton(() => DeleteFurniture(repository: sl()));
  sl.registerLazySingleton(() => UploadFurniture(repository: sl()));
  sl.registerLazySingleton(() => ReportFurniture(repository: sl()));
  sl.registerLazySingleton(() => GetFavorite(repository: sl()));
  sl.registerLazySingleton(() => AddFavorite(repository: sl()));
  sl.registerLazySingleton(() => DeleteFavorite(repository: sl()));

  sl.registerLazySingleton(() => UploadAuctionProductUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAuctionUseCase(sl()));
  sl.registerLazySingleton(() => GetAuctionProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetAuctionProductsSearchResultUseCase(sl()));
  sl.registerLazySingleton(() => ViewAuctionDataUseCase(sl()));
  sl.registerLazySingleton(() => BidAuctionUseCase(sl()));

  sl.registerLazySingleton(() => CreateConversation(repository: sl()));
  sl.registerLazySingleton(() => GetConversations(repository: sl()));
  sl.registerLazySingleton(() => GetMessages(repository: sl()));
  sl.registerLazySingleton(() => SendMessage(repository: sl()));
  sl.registerLazySingleton(() => GetUserName(repository: sl()));
}

void initRepository() {
  sl.registerLazySingleton<ECommerceRepository>(
    () => ECommerceRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenitcationRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<BaseAuctionRepository>(
      () => AuctionRepository(sl()));

  sl.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(remoteDataSource: sl()));
}

void initDataSources() {
  sl.registerLazySingleton<FurnitureRemoteDataSource>(
    () => FurnitureRemoteDataSourceImpl(
      dio: sl<Dio>(),
    ),
  );

  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(
      dio: sl<Dio>(),
    ),
  );
  sl.registerLazySingleton<BaseAuctionRemoteDataSource>(
    () => AuctionRemoteDataSource(
      dio: sl<Dio>(),
    ),
  );

  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(
      dio: sl<Dio>(),
    ),
  );
}

void initExternalPackages() {
  sl.registerLazySingleton<Dio>(() => Dio());
}
