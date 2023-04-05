import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/furniture_entity.dart';

abstract class ECommerceRepository {
  Future<Either<Failure, FurnitureEntity>> getFurnitureById({
    required int furnitureId,
  });

  Future<Either<Failure, List<FurnitureEntity>>>
      getPopularFurnitureByCategory();

  Future<Either<Failure, List<FurnitureEntity>>> getFurnitureByCategory({
    required String categoryId,
  });

  Future<Either<Failure, List<FurnitureEntity>>> getFurnitureFromSearch({
    required String searchQuery,
  });

  Future<Either<Failure, List<FurnitureEntity>>> getFurnitureFromFavorite({
    required int userId,
  });

  Future<Either<Failure, String>> uploadFurniture({
    required FurnitureEntity furniture,
  });
}
