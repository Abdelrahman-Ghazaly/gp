import 'package:dio/dio.dart';

import '../../../../core/app_constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/error_message_model.dart';
import '../../domain/entities/auction_entities.dart';

import '../models/auction_product_model.dart';

abstract class BaseAuctionRemoteDataSource {
  Future<List<AuctionEntities>> getAuctionProducts(String adminToken);

  Future<String> acceptAuctionProduct(String auctionId, String adminToken);
  Future<String> refuseAuctionProduct(String auctionId, String adminToken);
}

class AuctionRemoteDataSource extends BaseAuctionRemoteDataSource {
  final Dio dio;

  AuctionRemoteDataSource({required this.dio});
  @override
  Future<List<AuctionEntities>> getAuctionProducts(String adminToken) async {
    Response response = await dio.get(ApiConstants.auctionViewRequestsPath,
        options: Options(
          followRedirects: false,
          headers: {
            'token': "bearer $adminToken",
          },
        ));

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
  Future<String> acceptAuctionProduct(
      String auctionId, String adminToken) async {
    Response response = await dio.put(
      ApiConstants.auctionAcceptRequestsPath(
        auctionId,
      ),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: {
          'token': "bearer $adminToken",
        },
      ),
    );
    if (response.statusCode == 200) {
      return 'Accepted Succesfully';
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<String> refuseAuctionProduct(
      String auctionId, String adminToken) async {
    Response response = await dio.delete(
      ApiConstants.auctionRefuseRequestsPath(
        auctionId,
      ),
      options: Options(
        followRedirects: false,
        headers: {
          'token': "bearer $adminToken",
        },
      ),
    );
    if (response.statusCode == 200) {
      return 'Deleted Succesfully';
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
