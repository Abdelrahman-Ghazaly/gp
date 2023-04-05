import '../../../../core/error/exceptions.dart';
import '../data_sources/furniture_remote_data_source.dart';
import '../../domain/entities/search_query_entity.dart';

import '../../domain/entities/furniture_entity.dart';

import '../../../../core/error/failure.dart';

import '../../../../core/app_constants/app_values.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/network/network.dart';
import '../../domain/repositories/e_commerce_repository.dart';

typedef _RepositoryFunction = Future<List<FurnitureEntity>> Function();

class ECommerceRepositoryImpl implements ECommerceRepository {
  final FurnitureRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ECommerceRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<FurnitureEntity>>>
      getPopularFurnitureByCategory() async {
    return _getFurnitureList(
      () => remoteDataSource.getPopularFurnitureByCategory(),
    );
  }

  @override
  Future<Either<Failure, List<FurnitureEntity>>> getFurnitureFromSearchByQuery(
      {required String searchQuery}) async {
    return _getFurnitureList(
      () => remoteDataSource.getFurnitureFromSearchByQuery(
        searchQuery: searchQuery,
      ),
    );
  }

  @override
  Future<Either<Failure, List<FurnitureEntity>>>
      getFurnitureFromSearchByCategory({required Category category}) async {
    return _getFurnitureList(
      () =>
          remoteDataSource.getFurnitureFromSearchByCategory(category: category),
    );
  }

  @override
  Future<Either<Failure, List<FurnitureEntity>>>
      getFurnitureFromSearchByMinPrice({required int minPrice}) async {
    return _getFurnitureList(
      () =>
          remoteDataSource.getFurnitureFromSearchByMinPrice(minPrice: minPrice),
    );
  }

  @override
  Future<Either<Failure, List<FurnitureEntity>>>
      getFurnitureFromSearchByMaxPrice({required int maxPrice}) async {
    return _getFurnitureList(
      () =>
          remoteDataSource.getFurnitureFromSearchByMaxPrice(maxPrice: maxPrice),
    );
  }

  @override
  Future<Either<Failure, List<FurnitureEntity>>>
      getFurnitureFromSearchByCategoryAndPrice(
          {required CategoryQueryEntity categoryQueryEntity}) async {
    return _getFurnitureList(
      () => remoteDataSource.getFurnitureFromSearchByCategoryAndPrice(
          categoryQueryEntity: categoryQueryEntity),
    );
  }

  @override
  Future<Either<Failure, List<FurnitureEntity>>>
      getFurnitureFromSearchByPriceRange(
          {required int minPrice, required int maxPrice}) async {
    return _getFurnitureList(
      () => remoteDataSource.getFurnitureFromSearchByPriceRange(
        minPrice: minPrice,
        maxPrice: maxPrice,
      ),
    );
  }

  @override
  Future<Either<Failure, String>> uploadFurniture(
      {required FurnitureEntity furniture}) {
    // TODO: implement uploadFurniture
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> deleteProduct({required int productId}) {
    // TODO: implement getFurnitureFromSearchByCategory
    throw UnimplementedError();
  }

  Future<Either<Failure, List<FurnitureEntity>>> _getFurnitureList(
      _RepositoryFunction repositoryFunction) async {
    try {
      final List<FurnitureEntity> result = await repositoryFunction();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
