import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/furniture_entity.dart';

abstract class ECommerceRepository {
  Future<Either<Failure, FurnitureEntity>> getFurniture(int furnitureId);

  Future<Either<Failure, List<FurnitureEntity>>> getPopularFurniture();

  Future<Either<Failure, List<FurnitureEntity>>> getFurnitureByCategory();

  Future<Either<Failure, List<FurnitureEntity>>> getFurnitureFromSearch();

  Future<Either<Failure, List<FurnitureEntity>>> getFurnitureFromFavorite();
}
