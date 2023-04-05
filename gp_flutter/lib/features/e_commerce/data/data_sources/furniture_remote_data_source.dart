import 'package:dio/dio.dart';
import 'package:gp_flutter/core/app_constants/app_values.dart';
import 'package:gp_flutter/core/error/exceptions.dart';
import 'package:gp_flutter/core/network/error_message_model.dart';
import 'package:gp_flutter/features/e_commerce/data/models/furniture_model.dart';

import '../../domain/entities/furniture_entity.dart';

abstract class FurnitureRemoteDataSource {
  Future<FurnitureEntity> getFurnitureById({required int furnitureId});

  Future<List<FurnitureEntity>> getPopularFurnitureByCategory();

  Future<List<FurnitureEntity>> getFurnitureByCategory(
      {required String categoryId});

  Future<List<FurnitureEntity>> getFurnitureFromSearch(
      {required String searchQuery});

  Future<List<FurnitureEntity>> getFurnitureFromFavorite({required int userId});

  Future<String> uploadFurniture({required FurnitureEntity furniture});
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
  Future<FurnitureEntity> getFurnitureById({required int furnitureId}) async {
    // TODO: implement getFurnitureByCategory
    throw UnimplementedError();
  }

  @override
  Future<List<FurnitureEntity>> getFurnitureByCategory(
      {required String categoryId}) async {
    // TODO: implement getFurnitureFromFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<FurnitureEntity>> getFurnitureFromFavorite(
      {required int userId}) async {
    // TODO: implement getFurnitureFromFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearch(
      {required String searchQuery}) async {
    // TODO: implement getFurnitureFromSearch
    throw UnimplementedError();
  }

  @override
  Future<List<FurnitureEntity>> getPopularFurnitureByCategory() async {
    Response response = await _dio.get(kJsonServerUrl);
    if (response.statusCode == 200) {
      return List<FurnitureModel>.from(
        [response.data].map(
          (element) => FurnitureModel.fromMap(element),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<String> uploadFurniture({required FurnitureEntity furniture}) async {
    // TODO: implement uploadFurniture
    throw UnimplementedError();
  }
}
