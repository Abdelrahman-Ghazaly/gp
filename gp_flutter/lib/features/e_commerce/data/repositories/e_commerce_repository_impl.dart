import 'package:dartz/dartz.dart';
import 'package:gp_flutter/features/e_commerce/domain/entities/report_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../authentication/domain/entities/user_entity.dart';
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
  Future<Either<Failure, String>> uploadFurniture({
    required FurnitureModel furniture,
    required UserEntity userEntity,
  }) async =>
      await _getString(() => remoteDataSource.uploadFurniture(
            furniture: furniture,
            userEntity: userEntity,
          ));

  @override
  Future<Either<Failure, String>> deleteFurniture({
    required String productId,
    required String accessToken,
  }) {
    // TODO: implement deleteFurniture
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

  @override
  Future<
      Either<
          Failure,
          ({
            UserEntity userEntity,
            List<FurnitureEntity> productsList,
          })>> getUserData(
      {required String accessToken, required String userId}) async {
    try {
      final ({
        UserEntity userEntity,
        List<FurnitureEntity> productsList,
      }) result = await remoteDataSource.getUserData(
        accessToken: accessToken,
        userId: userId,
      );
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> addFavorite(
      {required String productId, required String accessToken}) async {
    try {
      final String result = await remoteDataSource.addFavorite(
          accessToken: accessToken, productId: productId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> deleteFavorite(
      {required String productId, required String accessToken}) async {
    try {
      final String result = await remoteDataSource.deleteFavorite(
          accessToken: accessToken, productId: productId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<FurnitureEntity>>> getFavorite(
      {required String accessToken}) async {
    try {
      final List<FurnitureEntity> result =
          await remoteDataSource.getFavorite(accessToken: accessToken);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> reportFurniture(
      {required String productId,
      required String accessToken,
      required ReportEntity report}) async {
    try {
      final String result = await remoteDataSource.reportFurniture(
        productId: productId,
        accessToken: accessToken,
        report: report,
      );
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
