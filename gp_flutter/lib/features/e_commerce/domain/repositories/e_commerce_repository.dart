import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/furniture_entity.dart';

abstract class ECommerceRepository {
  Future<Either<Failure, FurnitureEntity>> getFurniture({
    required int furnitureId,
  });

  Future<Either<Failure, List<FurnitureEntity>>> getPopularFurniture();

  Future<Either<Failure, List<FurnitureEntity>>> getFurnitureByCategory({
    required int categoryId,
  });

  Future<Either<Failure, List<FurnitureEntity>>> getFurnitureFromSearch({
    required String searchQuery,
  });
  Future<Either<Failure, List<FurnitureEntity>>> getFurnitureFromFavorite({
    required int userId,
  });
}
