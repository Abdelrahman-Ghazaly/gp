import 'package:dio/dio.dart';

import '../../../../core/app_constants/api_constants.dart';
import '../../../../core/app_constants/app_values.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/error_message_model.dart';
import '../../domain/entities/furniture_entity.dart';
import '../../domain/entities/search_query_entity.dart';
import '../models/furniture_model.dart';

abstract class FurnitureRemoteDataSource {
  Future<List<FurnitureEntity>> getPopularFurnitureByCategory();

  Future<List<FurnitureEntity>> getFurnitureFromSearchByQuery({
    required String searchQuery,
  });
  Future<List<FurnitureEntity>> getFurnitureFromSearchByCategory({
    required Category category,
  });
  Future<List<FurnitureEntity>> getFurnitureFromSearchByCategoryAndPrice({
    required CategoryQueryEntity categoryQueryEntity,
  });
  Future<List<FurnitureEntity>> getFurnitureFromSearchByPriceRange({
    required int minPrice,
    required int maxPrice,
  });
  Future<List<FurnitureEntity>> getFurnitureFromSearchByMinPrice({
    required int minPrice,
  });
  Future<List<FurnitureEntity>> getFurnitureFromSearchByMaxPrice({
    required int maxPrice,
  });

  Future<String> uploadFurniture({
    required FurnitureEntity furniture,
  });

  Future<String> deleteProduct({
    required int productId,
  });
}

class FurnitureRemoteDataSourceImpl extends FurnitureRemoteDataSource {
  static final FurnitureRemoteDataSourceImpl _singleton =
      FurnitureRemoteDataSourceImpl._internal();

  factory FurnitureRemoteDataSourceImpl() {
    return _singleton;
  }

  FurnitureRemoteDataSourceImpl._internal();

  final Dio _dio = Dio();

  @override
  Future<List<FurnitureEntity>> getPopularFurnitureByCategory() =>
      _getFurnitureList(
        ApiConstants.popularFurnitureByCategoryPath,
      );

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByQuery(
          {required String searchQuery}) =>
      _getFurnitureList(
        ApiConstants.furnitureFromSearcByQueryhPath(searchQuery),
      );

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByCategory(
          {required Category category}) =>
      _getFurnitureList(
        ApiConstants.furnitureFromSearcByCategory(category),
      );

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByCategoryAndPrice(
          {required CategoryQueryEntity categoryQueryEntity}) =>
      _getFurnitureList(
        ApiConstants.furnitureFromSearcByCategoryAndPricePath(
          categoryQueryEntity,
        ),
      );

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByMaxPrice(
          {required int maxPrice}) =>
      _getFurnitureList(
        ApiConstants.furnitureFromSearcByMaxPricePath(maxPrice),
      );

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByMinPrice(
          {required int minPrice}) =>
      _getFurnitureList(
        ApiConstants.furnitureFromSearcByMinPricePath(minPrice),
      );

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByPriceRange(
          {required int minPrice, required int maxPrice}) =>
      _getFurnitureList(
        ApiConstants.furnitureFromSearcByPriceRangePath(minPrice, maxPrice),
      );

  @override
  Future<String> uploadFurniture({required FurnitureEntity furniture}) {
    // TODO: implement uploadFurniture
    throw UnimplementedError();
  }

  @override
  Future<String> deleteProduct({required int productId}) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  Future<List<FurnitureEntity>> _getFurnitureList(String url) async {
    Response response = await _dio.get(
      url,
      data: {
        'Content-Type': 'application / json',
      },
    );
    if (response.statusCode == 200) {
      return List.from(
        [response.data].map((element) => FurnitureModel.fromMap(element)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
