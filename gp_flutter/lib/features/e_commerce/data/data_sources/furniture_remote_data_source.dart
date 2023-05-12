import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:gp_flutter/features/authentication/domain/entities/user_entity.dart';

import '../../../../core/app_constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/error_message_model.dart';
import '../../domain/entities/furniture_entity.dart';
import '../../domain/entities/query_entity.dart';
import '../../domain/entities/seller_entity.dart';
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
    required UserEntity userEntity,
  });

  Future<String> deleteFurniture({
    required int productId,
    required UserEntity userEntity,
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
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
      ),
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
  Future<String> uploadFurniture({
    required FurnitureModel furniture,
    required UserEntity userEntity,
  }) async {
    ByteData byteData = await rootBundle.load('assets/images/productImage.png');
    Uint8List rawImage = byteData.buffer.asUint8List();
    Map<String, dynamic> map = {
      "title": furniture.title,
      'description': furniture.description,
      'imgURL': rawImage,
      'category': furniture.category,
      'price': furniture.price,
    };
    FormData data = FormData.fromMap(map);

    Response response = await dio.post(
      ApiConstants.uploadFurniturePath,
      options: Options(
        method: 'POST',
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: {
          HttpHeaders.contentTypeHeader: 'multipart/form-data',
          'token': "Bearer ${userEntity.accessToken}",
        },
      ),
      data: data,
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
  Future<String> deleteFurniture({
    required int productId,
    required UserEntity userEntity,
  }) {
    // TODO: implement deleteFurniture
    throw UnimplementedError();
  }

  Future<List<FurnitureEntity>> _getFurnitureList({required String url}) async {
    Response response = await dio.get(
      url,
      data: {
        'Content-Type': 'application / json',
      },
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
      ),
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
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
      ),
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
