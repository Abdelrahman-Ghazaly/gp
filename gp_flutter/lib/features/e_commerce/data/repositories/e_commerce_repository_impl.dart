import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/furniture_entity.dart';
import '../../domain/entities/query_entity.dart';
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
  Future<Either<Failure, List<FurnitureEntity>>> getFurnitureFromSearch(
      {required QueryEntity queryEntity}) {
    return _getFurnitureList(
      () => remoteDataSource.getFurnitureFromSearch(
        queryEntity: queryEntity,
      ),
    );
  }

  @override
  Future<Either<Failure, FurnitureEntity>> getFurnitureFromId(
      {required String id}) async {
    try {
      final FurnitureEntity result =
          await remoteDataSource.getFurnitureFromId(id: id);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
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
