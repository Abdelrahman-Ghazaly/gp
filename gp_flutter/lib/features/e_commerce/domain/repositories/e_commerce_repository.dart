import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../authentication/domain/entities/user_entity.dart';
import '../../data/models/furniture_model.dart';
import '../entities/furniture_entity.dart';
import '../entities/query_entity.dart';

abstract class ECommerceRepository {
  Future<Either<Failure, Map<String, List<FurnitureEntity>>>>
      getPopularFurnitureByCategory();

  Future<Either<Failure, FurnitureEntity>> getFurnitureFromId({
    required String id,
  });

  Future<Either<Failure, List<FurnitureEntity>>> getFurnitureFromSearch({
    required QueryEntity queryEntity,
  });

  Future<
      Either<
          Failure,
          ({
            UserEntity userEntity,
            List<FurnitureEntity> productsList,
          })>> getUserData({
    required String userId,
    required String accessToken,
  });

  Future<Either<Failure, String>> uploadFurniture({
    required FurnitureModel furniture,
    required UserEntity userEntity,
  });

  Future<Either<Failure, String>> deleteFurniture({
    required int productId,
    required UserEntity userEntity,
  });

  Future<Either<Failure, List<FurnitureEntity>>>
      getFavoriteFromRemoteDataSource({
    required String accessToken,
  });

  Future<Either<Failure, String>> addFavoriteFromRemoteDataSource({
    required String productId,
    required String accessToken,
  });

  Future<Either<Failure, String>> deleteFavoriteFromRemoteDataSource({
    required String productId,
    required String accessToken,
  });

  Future<Either<Failure, List<String>>> getFavoriteFromLocalDataSource();

  Future<Either<Failure, void>> addFavoriteFromLocalDataSource({
    required List<String> favoritesIds,
  });
}
