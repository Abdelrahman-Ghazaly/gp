import 'package:dio/dio.dart';

import '../../../../core/app_constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/error_message_model.dart';
import '../../domain/entities/auction_entities.dart';

import '../models/auction_product_model.dart';

abstract class BaseAuctionRemoteDataSource {
  Future<List<AuctionEntities>> getAuctionProducts();

  Future<int> acceptAuctionProduct(String auctionId, String adminToken);
  Future<int> refuseAuctionProduct(String auctionId, String adminToken);
}

class AuctionRemoteDataSource extends BaseAuctionRemoteDataSource {
  final Dio dio;

  AuctionRemoteDataSource({required this.dio});
  @override
  Future<List<AuctionEntities>> getAuctionProducts() async {
    Response response = await dio.get(
      ApiConstants.auctionViewRequestsPath,
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
  Future<int> acceptAuctionProduct(String auctionId, String adminToken) {
    // TODO: implement uploadAuctionProduct
    throw UnimplementedError();
  }

  @override
  Future<int> refuseAuctionProduct(String auctionId, String adminToken) {
    // TODO: implement refuseAuctionProduct
    throw UnimplementedError();
  }
}
