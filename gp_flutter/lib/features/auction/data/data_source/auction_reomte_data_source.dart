import 'package:dio/dio.dart';
import '../../../../core/app_constants/api_constants.dart';
import '../models/auction_product_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/error_message_model.dart';
import '../../domain/entities/auction_entities.dart';

abstract class BaseAuctionRemoteDataSource {
  Future<List<AuctionEntities>> getAuctionProducts();

  Future<AuctionEntities> viewAuctionDataById(String auctionId);

  Future<List<AuctionEntities>> getAuctionProductsSearchResult();

  Future<int> uploadAuctionProduct(AuctionEntities auctionProduct);

  Future<int> deleteAuction(String userToken);
}

class AuctionRemoteDataSource extends BaseAuctionRemoteDataSource {
  final Dio dio;

  AuctionRemoteDataSource({required this.dio});

  @override
  Future<int> deleteAuction(String userToken) {
    // TODO: implement deleteAuction
    throw UnimplementedError();
  }

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
  Future<List<AuctionEntities>> getAuctionProductsSearchResult() async {
    // TODO: implement getAuctionProductsSearchResult
    throw UnimplementedError();
  }

  @override
  Future<int> uploadAuctionProduct(AuctionEntities auctionProduct) {
    // TODO: implement uploadAuctionProduct
    throw UnimplementedError();
  }
}
