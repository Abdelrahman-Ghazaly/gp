import 'package:dartz/dartz.dart';

import '../../../../core/app_constants/app_constants.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/furniture_model.dart';
import '../entities/furniture_entity.dart';
import '../entities/search_query_entity.dart';

abstract class ECommerceRepository {
  Future<Either<Failure, Map<String, List<FurnitureEntity>>>>
      getPopularFurnitureByCategory();

  Future<Either<Failure, List<FurnitureEntity>>> getFurnitureFromSearchByQuery({
    required String searchQuery,
  });

  Future<Either<Failure, List<FurnitureEntity>>>
      getFurnitureFromSearchByCategory({
    required Category category,
  });

  Future<Either<Failure, List<FurnitureEntity>>>
      getFurnitureFromSearchByMinPrice({
    required int minPrice,
  });

  Future<Either<Failure, List<FurnitureEntity>>>
      getFurnitureFromSearchByMaxPrice({
    required int maxPrice,
  });

  Future<Either<Failure, List<FurnitureEntity>>>
      getFurnitureFromSearchByPriceRange({
    required int minPrice,
    required int maxPrice,
  });

  Future<Either<Failure, List<FurnitureEntity>>>
      getFurnitureFromSearchByCategoryAndPrice({
    required CategoryQueryEntity categoryQueryEntity,
  });

  Future<Either<Failure, String>> uploadFurniture({
    required FurnitureModel furniture,
  });

  Future<Either<Failure, String>> deleteFurniture({
    required int productId,
  });
}
