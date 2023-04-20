import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:gp_flutter/core/app_constants/api_constants.dart';
import 'package:gp_flutter/features/auction/data/models/auction_product_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/error_message_model.dart';
import '../../domain/entities/auction_product.dart';

abstract class BaseAuctionRemoteDataSource {
  Future<List<AuctionProduct>> getAuctionProducts();

  Future<List<AuctionProduct>> getAuctionProductsSearchResult();

  Future<int> uploadAuctionProduct(AuctionProduct auctionProduct);

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
  Future<List<AuctionProduct>> getAuctionProducts() async {
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
  Future<List<AuctionProduct>> getAuctionProductsSearchResult() async {
    // TODO: refactor
    final response =
        await http.get(Uri.parse(ApiConstants.auctionViewProductPath));
    if (response.statusCode == 200) {
      return List<AuctionProductModel>.from(
          (jsonDecode(response.body))["Products"]
              .map((e) => AuctionProductModel.fromJson(e))
              .toList());
    } else {
      throw ServerException(
          errorMessageModel:
              ErrorMessageModel.fromJson(jsonDecode(response.body)));
    }
    // TODO: implement getAuctionProductsSearchResult
    throw UnimplementedError();
  }

  @override
  Future<int> uploadAuctionProduct(AuctionProduct auctionProduct) {
    // TODO: implement uploadAuctionProduct
    throw UnimplementedError();
  }
}