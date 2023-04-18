import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gp_flutter/features/auction/data/data_source/auction_reomte_data_source.dart';
import 'package:gp_flutter/features/auction/data/repository/auction_repository.dart';
import 'package:gp_flutter/features/auction/domain/usecases/delete_auction_usecase.dart';
import 'package:gp_flutter/features/auction/domain/usecases/get_auction_products_search_result_usecase.dart';
import 'package:gp_flutter/features/auction/domain/usecases/get_auction_products_usecase.dart';
import 'package:gp_flutter/features/auction/domain/usecases/upload_auction_product_usecase.dart';
import 'package:gp_flutter/features/e_commerce/data/repositories/e_commerce_repository_impl.dart';
import 'package:gp_flutter/features/e_commerce/domain/use_cases/delete_product.dart';
import 'package:gp_flutter/features/e_commerce/domain/use_cases/upload_furniture.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/e_commerce_bloc.dart';

import '../../features/e_commerce/data/data_sources/furniture_remote_data_source.dart';
import '../../features/e_commerce/domain/repositories/e_commerce_repository.dart';
import '../../features/e_commerce/domain/use_cases/get_furniture_from_search_by_category.dart';
import '../../features/e_commerce/domain/use_cases/get_furniture_from_search_by_category_and_price.dart';
import '../../features/e_commerce/domain/use_cases/get_furniture_from_search_by_max_price.dart';
import '../../features/e_commerce/domain/use_cases/get_furniture_from_search_by_min_price.dart';
import '../../features/e_commerce/domain/use_cases/get_furniture_from_search_by_price_range.dart';
import '../../features/e_commerce/domain/use_cases/get_furniture_from_search_by_query.dart';
import '../../features/e_commerce/domain/use_cases/get_popular_furniture_by_category.dart';

final sl = GetIt.instance;

void init() {
  initBloc();
  initFeatures();
  initRepository();
  initDataSources();
  initExternalPackages();
}

void initBloc() {
  sl.registerFactory(
    () => ECommerceBloc(
      getFurnitireFromSearchByCategoryAndPrice: sl(),
      getFurnitireFromSearchByPriceRange: sl(),
      getFurnitureFromSearchByCategory: sl(),
      getFurnitureFromSearchByMaxPrice: sl(),
      getFurnitureFromSearchByMinPrice: sl(),
      getFurnitureFromSearchByQuery: sl(),
      getPopularFurniturebyCategory: sl(),
      deleteFurniture: sl(),
      uploadFurniture: sl(),
    ),
  );
}

void initFeatures() {
  sl.registerLazySingleton(
    () => GetFurnitureFromSearchByCategoryAndPrice(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetFurnitureFromSearchByPriceRange(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetFurnitureFromSearchByCategory(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetFurnitureFromSearchByMaxPrice(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetFurnitureFromSearchByMinPrice(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetFurnitureFromSearchByQuery(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetPopularFurniturebyCategory(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => DeleteFurniture(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => UploadFurniture(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(() => UploadAuctionProductUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAuctionUseCase(sl()));
  sl.registerLazySingleton(() => GetAuctionProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetAuctionProductsSearchResultUseCase(sl()));
}

void initRepository() {
  sl.registerLazySingleton<ECommerceRepository>(
    () => ECommerceRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<AuctionRepository>(() => AuctionRepository(sl()));
}

void initDataSources() {
  sl.registerLazySingleton<FurnitureRemoteDataSource>(
    () => FurnitureRemoteDataSourceImpl(
      dio: sl(),
    ),
  );
  sl.registerLazySingleton<BaseAuctionRemoteDataSource>(
      () => AuctionRemoteDataSource(
            dio: sl(),
          ));
}

void initExternalPackages() {
  sl.registerLazySingleton(() => Dio());
}
