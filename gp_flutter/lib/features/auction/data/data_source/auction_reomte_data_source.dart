import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/app_constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/error_message_model.dart';
import '../../domain/entities/auction_entities.dart';
import '../../domain/entities/search_query_entity.dart';
import '../models/auction_product_model.dart';

abstract class BaseAuctionRemoteDataSource {
  Future<List<AuctionEntities>> getAuctionProducts();

  Future<AuctionEntities> viewAuctionDataById(String auctionId);

  Future<List<AuctionEntities>> getAuctionProductsSearchResult(
      SearchQueryEntity searchQueryEntity);

  Future<String> uploadAuctionProduct(
      AuctionEntities auctionProduct, String userToken);

  Future<String> deleteAuction(String userToken, String auctionId);
  Future<String> bidAuction(
      {required String userToken,
      required String auctionId,
      required int bidAmount});
}

class AuctionRemoteDataSource extends BaseAuctionRemoteDataSource {
  AuctionRemoteDataSource({required this.dio});
  final Dio dio;

  @override
  Future<List<AuctionEntities>> getAuctionProducts() async {
    Response response = await dio.get(
      ApiConstants.auctionViewProductPath,
    );

    if (response.statusCode == 200) {
      return List.from(
        (response.data).map((element) => AuctionProductModel.fromJson(element)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<AuctionEntities> viewAuctionDataById(String auctionId) async {
    Response response = await dio.get(
      ApiConstants.viewAuctionDataPath(auctionId),
    );

    if (response.statusCode == 200) {
      return AuctionProductModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<AuctionEntities>> getAuctionProductsSearchResult(
      SearchQueryEntity searchQueryEntity) async {
    Response response = await dio.get(
      ApiConstants.viewAuctionSearchDataPath(
          searchQueryEntity.category,
          searchQueryEntity.maxPrice,
          searchQueryEntity.name,
          searchQueryEntity.minPrice),
    );

    if (response.statusCode == 200) {
      return List.from(
        (response.data).map((element) => AuctionProductModel.fromJson(element)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<String> bidAuction(
      {required String userToken,
      required String auctionId,
      required int bidAmount}) async {
    Response response = await dio.put(
      ApiConstants.auctionBidProductPath(
        auctionId,
      ),
      data: {"bidAmount": bidAmount},
      options: Options(
        followRedirects: false,
        validateStatus: (int? status) {
          return status! < 600;
        },
        headers: {
          'token': "bearer $userToken",
        },
      ),
    );
    if (response.statusCode == 200) {
      return 'Bid Succesfully';
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<String> uploadAuctionProduct(
      AuctionEntities auctionProduct, String userToken) async {
    XFile rawImage = auctionProduct.rawImage!;

    File file = File(rawImage.path);
    final String imageType = file.path.split('.').last;
    MultipartFile finalFile = await MultipartFile.fromFile(
      file.path,
      contentType: MediaType('image', imageType),
    );

    Map<String, dynamic> map = {
      "title": auctionProduct.title,
      'description': auctionProduct.description,
      'imgURL': [finalFile],
      'category': auctionProduct.category,
      'startPrice': auctionProduct.startPrice,
      "duration": int.parse(auctionProduct.duration),
    };
    FormData data = FormData.fromMap(map);

    Response response = await dio.post(
      ApiConstants.auctionUploadProductPath,
      options: Options(
        method: 'POST',
        followRedirects: false,
        validateStatus: (int? status) {
          return status! < 600;
        },
        headers: {
          'token': "Bearer $userToken",
        },
      ),
      data: data,
    );
    if (response.statusCode == 201) {
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
  Future<String> deleteAuction(String userToken, String auctionId) async {
    throw UnimplementedError();
  }
}
