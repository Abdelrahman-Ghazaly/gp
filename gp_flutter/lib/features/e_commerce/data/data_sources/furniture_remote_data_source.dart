import 'package:dio/dio.dart';
import 'package:gp_flutter/core/app_constants/api_constants.dart';
import 'package:gp_flutter/core/app_constants/app_values.dart';
import 'package:gp_flutter/core/error/exceptions.dart';
import 'package:gp_flutter/core/network/error_message_model.dart';
import 'package:gp_flutter/features/e_commerce/data/models/furniture_model.dart';

import '../../domain/entities/furniture_entity.dart';
import '../../domain/entities/search_query_entity.dart';

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
  Future<List<FurnitureEntity>> getPopularFurnitureByCategory() async {
    Response response = await _dio.get(
      ApiConstants.popularFurnitureByCategoryPath,
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

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByQuery(
      {required String searchQuery}) {
    // TODO: implement getFurnitureFromSearchByQuery
    throw UnimplementedError();
  }

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByCategory(
      {required Category category}) {
    // TODO: implement getFurnitureFromSearchByCategory
    throw UnimplementedError();
  }

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByCategoryAndPrice(
      {required CategoryQueryEntity categoryQueryEntity}) {
    // TODO: implement getFurnitureFromSearchByCategoryAndPrice
    throw UnimplementedError();
  }

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByMaxPrice(
      {required int maxPrice}) {
    // TODO: implement getFurnitureFromSearchByMaxPrice
    throw UnimplementedError();
  }

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByMinPrice(
      {required int minPrice}) {
    // TODO: implement getFurnitureFromSearchByMinPrice
    throw UnimplementedError();
  }

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByPriceRange(
      {required int minPrice, required int maxPrice}) {
    // TODO: implement getFurnitureFromSearchByPriceRange
    throw UnimplementedError();
  }

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
}
