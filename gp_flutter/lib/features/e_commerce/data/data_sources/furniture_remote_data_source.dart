import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gp_flutter/features/auction/data/models/auction_product_model.dart';
import 'package:gp_flutter/features/auction/domain/entities/auction_entities.dart';
import 'package:gp_flutter/features/e_commerce/domain/entities/report_entity.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/app_constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/error_message_model.dart';
import '../../../authentication/data/models/user_model.dart';
import '../../../authentication/domain/entities/user_entity.dart';
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

  Future<
      ({
        UserEntity userEntity,
        List<FurnitureEntity> productsList,
        List<AuctionEntities> auctionList,
      })> getUserData({
    required String accessToken,
    required String userId,
  });

  Future<String> uploadFurniture({
    required FurnitureModel furniture,
    required UserEntity userEntity,
  });

  Future<String> deleteFurniture({
    required String productId,
    required String accessToken,
    required bool isAuction,
  });

  Future<String> reportFurniture({
    required String productId,
    required String accessToken,
    required ReportEntity report,
  });

  Future<String> addFavorite({
    required String productId,
    required String accessToken,
  });

  Future<String> deleteFavorite({
    required String productId,
    required String accessToken,
  });

  Future<List<FurnitureEntity>> getFavorite({
    required String accessToken,
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
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: response.statusMessage!,
        ),
      );
    }
  }

//
  @override
  Future<
          ({
            UserEntity userEntity,
            List<FurnitureEntity> productsList,
            List<AuctionEntities> auctionList
          })>
      getUserData({required String accessToken, required String userId}) async {
    Response response = await dio.get(
      ApiConstants.viewProfilePath(userId),
      options: Options(
        method: 'Get',
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: {
          'token': "Bearer $accessToken",
        },
      ),
    );
    if (response.statusCode == 200) {
      UserEntity userEntity = UserModel.fromMap(response.data['user-data']);
      List<FurnitureEntity> productsList = List.from(
        (response.data['user-data']['product_logs']).map(
          (element) => FurnitureModel.fromMap(element),
        ),
      );
      List<AuctionEntities> auctionList = List.from(
        (response.data['user-data']['auction_logs']).map(
          (element) => AuctionProductModel.fromJson(element),
        ),
      );
      return (
        userEntity: userEntity,
        productsList: productsList,
        auctionList: auctionList
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: response.statusMessage!,
        ),
      );
    }
  }

  @override
  Future<String> uploadFurniture({
    required FurnitureModel furniture,
    required UserEntity userEntity,
  }) async {
    XFile rawImage = furniture.rawImage!;

    File file = File(rawImage.path);
    final String imageType = file.path.split('.').last;
    var finalFile = await MultipartFile.fromFile(
      file.path,
      contentType: MediaType('image', imageType),
    );

    Map<String, dynamic> map = {
      "title": furniture.title,
      'description': furniture.description,
      'imgURL': [finalFile],
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
          'token': "Bearer ${userEntity.accessToken}",
        },
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      return 'Uploaded Succesfully';
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: response.statusMessage!,
        ),
      );
    }
  }

  @override
  Future<String> deleteFurniture({
    required String productId,
    required String accessToken,
    required bool isAuction,
  }) async {
    Response response = await dio.delete(
      isAuction
          ? ApiConstants.auctionDeleteProductPath(productId)
          : ApiConstants.deleteFurniturePath(productId),
      options: Options(
        method: 'DELETE',
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: {
          'token': "Bearer $accessToken",
        },
      ),
    );
    if (response.statusCode == 200) {
      return 'Deleted Succesfully';
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: response.statusMessage!,
        ),
      );
    }
  }

  @override
  Future<String> reportFurniture({
    required String productId,
    required String accessToken,
    required ReportEntity report,
  }) async {
    Map data = {
      'report_type': report.reportType,
      'description': report.description
    };
    Response response = await dio.post(
      ApiConstants.reportFurniturePath(productId),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: {
          'token': "Bearer $accessToken",
        },
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return 'Reported Succesfully';
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: response.statusMessage!,
        ),
      );
    }
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
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: response.statusMessage!,
        ),
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
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: response.statusMessage!,
        ),
      );
    }
  }

  @override
  Future<String> addFavorite(
      {required String productId, required String accessToken}) async {
    Response response = await dio.post(
      ApiConstants.addFavoritePath(productId: productId),
      options: Options(
        method: 'POST',
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: {
          'token': "Bearer $accessToken",
        },
      ),
    );
    if (response.statusCode == 200) {
      return 'Added Succesfully';
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: response.statusMessage!,
        ),
      );
    }
  }

  @override
  Future<String> deleteFavorite(
      {required String productId, required String accessToken}) async {
    Response response = await dio.delete(
      ApiConstants.deleteFavoritePath(productId: productId),
      options: Options(
        method: 'DELETE',
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: {
          'token': "Bearer $accessToken",
        },
      ),
    );
    if (response.statusCode == 200) {
      return 'Deleted Succesfully';
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: response.statusMessage!,
        ),
      );
    }
  }

  @override
  Future<List<FurnitureEntity>> getFavorite(
      {required String accessToken}) async {
    Response response = await dio.get(
      ApiConstants.getFavoritePath,
      data: {
        'Content-Type': 'application / json',
      },
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: {
          'token': "Bearer $accessToken",
        },
      ),
    );
    if (response.statusCode == 200) {
      return List.from(
        (response.data).map((element) => FurnitureModel.fromMap(element)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: response.statusMessage!,
        ),
      );
    }
  }
}
