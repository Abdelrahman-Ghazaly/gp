import 'package:dartz/dartz.dart';
import 'package:gp_flutter/features/auction/domain/entities/auction_entities.dart';

import '../../../../core/error/failure.dart';
import '../../../authentication/domain/entities/user_entity.dart';
import '../../data/models/furniture_model.dart';
import '../entities/furniture_entity.dart';
import '../entities/query_entity.dart';
import '../entities/report_entity.dart';

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
            List<AuctionEntities> auctionList
          })>> getUserData({
    required String userId,
    required String accessToken,
  });

  Future<Either<Failure, String>> uploadFurniture({
    required FurnitureModel furniture,
    required UserEntity userEntity,
  });

  Future<Either<Failure, String>> deleteFurniture({
    required String productId,
    required String accessToken,
    required bool isAuction,
  });

  Future<Either<Failure, String>> reportFurniture({
    required String productId,
    required String accessToken,
    required ReportEntity report,
  });

  Future<Either<Failure, List<FurnitureEntity>>> getFavorite({
    required String accessToken,
  });

  Future<Either<Failure, String>> addFavorite({
    required String productId,
    required String accessToken,
  });

  Future<Either<Failure, String>> deleteFavorite({
    required String productId,
    required String accessToken,
  });
}
