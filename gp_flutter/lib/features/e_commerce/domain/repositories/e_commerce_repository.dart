import 'package:gp_flutter/features/e_commerce/domain/entities/furniture_entity.dart';

abstract class ECommerceRepository {
  Future<List<FurnitureEntity>> getFurniture();

  Future<List<FurnitureEntity>> getPopularFurniture();

  Future<List<FurnitureEntity>> getFurnitureByCategory();

  Future<List<FurnitureEntity>> getFurnitureFromSearch();

  Future<List<FurnitureEntity>> getFurnitureFromFavorite();
}
