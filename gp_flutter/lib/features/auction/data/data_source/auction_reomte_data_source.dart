import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:gp_flutter/core/app_constants/api_constants.dart';
import 'package:gp_flutter/features/auction/data/models/auction_product_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/error_message_model.dart';
import '../../domain/entities/auction_entities.dart';

abstract class BaseAuctionRemoteDataSource {
  Future<List<AuctionEntities>> getAuctionProducts();

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
    // TODO: Check which one @Osama
    // final response =
    //     await http.get(Uri.parse(ApiConstants.auctionViewProductPath));
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
