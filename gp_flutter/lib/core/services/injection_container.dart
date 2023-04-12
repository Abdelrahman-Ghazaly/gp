import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gp_flutter/features/e_commerce/data/repositories/e_commerce_repository_impl.dart';
import 'package:gp_flutter/features/e_commerce/domain/use_cases/delete_product.dart';
import 'package:gp_flutter/features/e_commerce/domain/use_cases/upload_furniture.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/e_commerce_bloc.dart';

import 'features/e_commerce/data/data_sources/furniture_remote_data_source.dart';
import 'features/e_commerce/domain/repositories/e_commerce_repository.dart';
import 'features/e_commerce/domain/use_cases/get_furniture_from_search_by_category.dart';
import 'features/e_commerce/domain/use_cases/get_furniture_from_search_by_category_and_price.dart';
import 'features/e_commerce/domain/use_cases/get_furniture_from_search_by_max_price.dart';
import 'features/e_commerce/domain/use_cases/get_furniture_from_search_by_min_price.dart';
import 'features/e_commerce/domain/use_cases/get_furniture_from_search_by_price_range.dart';
import 'features/e_commerce/domain/use_cases/get_furniture_from_search_by_query.dart';
import 'features/e_commerce/domain/use_cases/get_popular_furniture_by_category.dart';

final serviceLocator = GetIt.instance;

void init() {
  initBloc();
  initFeatures();
  initRepository();
  initDataSources();
  initExternalPackages();
}

void initBloc() {
  serviceLocator.registerFactory(
    () => ECommerceBloc(
      getFurnitireFromSearchByCategoryAndPrice: serviceLocator(),
      getFurnitireFromSearchByPriceRange: serviceLocator(),
      getFurnitureFromSearchByCategory: serviceLocator(),
      getFurnitureFromSearchByMaxPrice: serviceLocator(),
      getFurnitureFromSearchByMinPrice: serviceLocator(),
      getFurnitureFromSearchByQuery: serviceLocator(),
      getPopularFurniturebyCategory: serviceLocator(),
      deleteFurniture: serviceLocator(),
      uploadFurniture: serviceLocator(),
    ),
  );
}

void initFeatures() {
  serviceLocator.registerLazySingleton(
    () => GetFurnitureFromSearchByCategoryAndPrice(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetFurnitureFromSearchByPriceRange(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetFurnitureFromSearchByCategory(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetFurnitureFromSearchByMaxPrice(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetFurnitureFromSearchByMinPrice(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetFurnitureFromSearchByQuery(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetPopularFurniturebyCategory(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => DeleteFurniture(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => UploadFurniture(
      repository: serviceLocator(),
    ),
  );
}

void initRepository() {
  serviceLocator.registerLazySingleton<ECommerceRepository>(
    () => ECommerceRepositoryImpl(
      remoteDataSource: serviceLocator(),
    ),
  );
}

void initDataSources() {
  serviceLocator.registerLazySingleton<FurnitureRemoteDataSource>(
    () => FurnitureRemoteDataSourceImpl(
      dio: serviceLocator(),
    ),
  );
}

void initExternalPackages() {
  serviceLocator.registerLazySingleton(() => Dio());
}
