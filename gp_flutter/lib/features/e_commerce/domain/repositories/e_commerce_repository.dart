import 'package:dartz/dartz.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/features/e_commerce/domain/entities/furniture_entity.dart';

abstract class ECommerceRepository {
  Future<Either<Failure, FurnitureEntity>> getFurniture(int furnitureId);

  Future<Either<Failure, List<FurnitureEntity>>> getPopularFurniture();

  Future<Either<Failure, List<FurnitureEntity>>> getFurnitureByCategory();

  Future<Either<Failure, List<FurnitureEntity>>> getFurnitureFromSearch();

  Future<Either<Failure, List<FurnitureEntity>>> getFurnitureFromFavorite();
}
