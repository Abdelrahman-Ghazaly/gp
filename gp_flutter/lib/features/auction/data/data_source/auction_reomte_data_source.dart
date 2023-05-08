import 'package:dio/dio.dart';

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

  Future<int> uploadAuctionProduct(
      AuctionEntities auctionProduct, String userToken);

  Future<int> deleteAuction(String userToken, String productId);
}

class AuctionRemoteDataSource extends BaseAuctionRemoteDataSource {
  final Dio dio;

  AuctionRemoteDataSource({required this.dio});

  @override
  Future<int> deleteAuction(String userToken, String productId) async {
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
  Future<List<AuctionEntities>> getAuctionProductsSearchResult(
      searchQueryEntity) async {
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
  Future<int> uploadAuctionProduct(
      AuctionEntities auctionProduct, String userToken) {
    // TODO: implement uploadAuctionProduct
    throw UnimplementedError();
  }
}
