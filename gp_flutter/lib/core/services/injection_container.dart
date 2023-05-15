import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

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
import '../../features/authentication/data/datasources/authentication_remote_data_source.dart';
import '../../features/authentication/data/repositories/authenitcation_repository_impl.dart';
import '../../features/authentication/domain/repositories/authentication_repository.dart';
import '../../features/authentication/domain/usecases/log_in.dart';
import '../../features/authentication/domain/usecases/sign_up.dart';
import '../../features/authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart';
import '../../features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
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

  sl.registerFactory(() => SignUpBloc(signUp: sl()));
  sl.registerFactory(() => LogInBloc(logIn: sl()));

  sl.registerFactory(() => AllAuctionsBloc(sl()));
  sl.registerFactory(() => GetAuctionByIdBloc(sl()));
  sl.registerFactory(() => SearchAuctionsBloc(sl()));
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

  sl.registerLazySingleton(() => UploadAuctionProductUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAuctionUseCase(sl()));
  sl.registerLazySingleton(() => GetAuctionProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetAuctionProductsSearchResultUseCase(sl()));
  sl.registerLazySingleton(() => ViewAuctionDataUseCase(sl()));
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
}

void initExternalPackages() {
  sl.registerLazySingleton(() => Dio());
}
