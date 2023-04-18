import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/app_constants/api_constants.dart';
import '../../../../core/app_constants/app_values.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/error_message_model.dart';
import '../../domain/entities/furniture_entity.dart';
import '../../domain/entities/search_query_entity.dart';
import '../models/furniture_model.dart';

abstract class FurnitureRemoteDataSource {
  Future<List<FurnitureEntity>> getPopularFurnitureByCategory({
    required Category category,
  });

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
    required FurnitureModel furniture,
  });

  Future<String> deleteFurniture({
    required int productId,
  });
}

class FurnitureRemoteDataSourceImpl extends FurnitureRemoteDataSource {
  final Dio dio;

  FurnitureRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<List<FurnitureEntity>> getPopularFurnitureByCategory(
          {required Category category}) =>
      _getPopularFurnitureList(
        url: ApiConstants.popularFurnitureByCategoryPath,
        category: category,
      );

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByQuery(
          {required String searchQuery}) =>
      _getFurnitureList(
        url: ApiConstants.furnitureFromSearcByQueryhPath(searchQuery),
      );

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByCategory(
          {required Category category}) =>
      _getFurnitureList(
        url: ApiConstants.furnitureFromSearcByCategory(category),
      );

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByCategoryAndPrice(
          {required CategoryQueryEntity categoryQueryEntity}) =>
      _getFurnitureList(
        url: ApiConstants.furnitureFromSearcByCategoryAndPricePath(
          categoryQueryEntity,
        ),
      );

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByMaxPrice(
          {required int maxPrice}) =>
      _getFurnitureList(
        url: ApiConstants.furnitureFromSearcByMaxPricePath(maxPrice),
      );

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByMinPrice(
          {required int minPrice}) =>
      _getFurnitureList(
        url: ApiConstants.furnitureFromSearcByMinPricePath(minPrice),
      );

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearchByPriceRange(
          {required int minPrice, required int maxPrice}) =>
      _getFurnitureList(
        url:
            ApiConstants.furnitureFromSearcByPriceRangePath(minPrice, maxPrice),
      );

  @override
  Future<String> uploadFurniture({required FurnitureModel furniture}) async {
    throw UnimplementedError();
    Response response = await dio.post(
      ApiConstants.uploadFurniturePath,
      options: Options(
        method: 'POST',
        headers: {
          HttpHeaders.contentTypeHeader: 'multipart/form-data',
          // TODO: After implementing the athentication
          // 'token': "Bearer $authenticationToken",
        },
      ),
      data: furniture.toMap(),
    );
    if (response.statusCode == 200) {
      return 'Uploaded Succesfully';
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<String> deleteFurniture({required int productId}) {
    // TODO: implement deleteFurniture
    throw UnimplementedError();
  }

  Future<List<FurnitureEntity>> _getFurnitureList({required String url}) async {
    Response response = await dio.get(
      url,
      data: {
        'Content-Type': 'application / json',
      },
    );
    if (response.statusCode == 200) {
      return List.from(
        (response.data).map((element) => FurnitureModel.fromMap(element)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  Future<List<FurnitureEntity>> _getPopularFurnitureList(
      {required String url, required Category category}) async {
    Response response = await dio.get(
      url,
      data: {
        'Content-Type': 'application / json',
      },
    );
    String categoryString = mapCategoryToString(category);
    if (response.data[categoryString] == null) {
      response.statusCode = -1;
      response.data = {
        'status_code': response.statusCode,
        'status_message': 'Data not found',
      };
    }
    if (response.statusCode == 200) {
      return List.from(
        (response.data[categoryString])
            .map((element) => FurnitureModel.fromMap(element)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
