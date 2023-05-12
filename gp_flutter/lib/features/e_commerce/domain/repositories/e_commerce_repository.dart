import 'package:dartz/dartz.dart';
import 'package:gp_flutter/features/authentication/domain/entities/user_entity.dart';
import 'package:gp_flutter/features/e_commerce/domain/entities/seller_entity.dart';

import '../../../../core/error/failure.dart';
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

  Future<Either<Failure, String>> uploadFurniture({
    required FurnitureModel furniture,
    required UserEntity userEntity,
  });

  Future<Either<Failure, String>> deleteFurniture({
    required int productId,
    required UserEntity userEntity,
  });
}
