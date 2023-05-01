import 'package:dartz/dartz.dart';

import '../../../../core/app_constants/app_values.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/furniture_entity.dart';
import '../../domain/entities/search_query_entity.dart';
import '../../domain/repositories/e_commerce_repository.dart';
import '../data_sources/furniture_remote_data_source.dart';
import '../models/furniture_model.dart';

typedef _RepositoryFurnitureListFunction = Future<List<FurnitureEntity>>
    Function();
typedef _RepositoryFurnitureMapFunction
    = Future<Map<String, List<FurnitureEntity>>> Function();
typedef _RepositoryStringFunction = Future<String> Function();

class ECommerceRepositoryImpl implements ECommerceRepository {
  final FurnitureRemoteDataSource remoteDataSource;

  ECommerceRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Map<String, List<FurnitureEntity>>>>
      getPopularFurnitureByCategory() async {
    return _getPopularFurnitureMap(
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
          {required FurnitureModel furniture}) async =>
      await _getString(
          () => remoteDataSource.uploadFurniture(furniture: furniture));

  @override
  Future<Either<Failure, String>> deleteFurniture({required int productId}) {
    // TODO: implement getFurnitureFromSearchByCategory
    throw UnimplementedError();
  }

  Future<Either<Failure, List<FurnitureEntity>>> _getFurnitureList(
      _RepositoryFurnitureListFunction repositoryFunction) async {
    try {
      final List<FurnitureEntity> result = await repositoryFunction();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  Future<Either<Failure, Map<String, List<FurnitureEntity>>>>
      _getPopularFurnitureMap(
          _RepositoryFurnitureMapFunction repositoryFunction) async {
    try {
      final Map<String, List<FurnitureEntity>> result =
          await repositoryFunction();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  Future<Either<Failure, String>> _getString(
      _RepositoryStringFunction repositoryFunction) async {
    try {
      final String result = await repositoryFunction();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
