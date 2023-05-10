import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/app_constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/error_message_model.dart';
import '../../domain/entities/furniture_entity.dart';
import '../../domain/entities/query_entity.dart';
import '../models/furniture_model.dart';

abstract class FurnitureRemoteDataSource {
  Future<Map<String, List<FurnitureEntity>>> getPopularFurnitureByCategory();

  Future<FurnitureEntity> getFurnitureFromId({
    required String id,
  });

  Future<List<FurnitureEntity>> getFurnitureFromSearch({
    required QueryEntity queryEntity,
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
  Future<Map<String, List<FurnitureEntity>>> getPopularFurnitureByCategory() =>
      _getPopularFurnitureMap(
        url: ApiConstants.popularFurnitureByCategoryPath,
      );

  @override
  Future<List<FurnitureEntity>> getFurnitureFromSearch(
          {required QueryEntity queryEntity}) =>
      _getFurnitureList(
        url: ApiConstants.getFurnitureFromSearch(queryEntity),
      );

  @override
  Future<FurnitureEntity> getFurnitureFromId({required String id}) async {
    String url = ApiConstants.viewProductPathById(id);
    Response response = await dio.get(
      url,
      data: {
        'Content-Type': 'application / json',
      },
    );
    if (response.statusCode == 200) {
      return FurnitureModel.fromMap(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

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

  Future<Map<String, List<FurnitureEntity>>> _getPopularFurnitureMap(
      {required String url}) async {
    Response response = await dio.get(
      url,
      data: {
        'Content-Type': 'application / json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, List<FurnitureEntity>> popularFurniture = {};
      for (var key in response.data.keys) {
        popularFurniture.addAll({
          key: List.from(
            (response.data[key])
                .map((element) => FurnitureModel.fromMap(element)),
          )
        });
      }

      return popularFurniture;
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
