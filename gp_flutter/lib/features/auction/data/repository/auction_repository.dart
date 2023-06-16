import 'package:dartz/dartz.dart';
import 'package:gp_flutter/features/auction/domain/entities/search_query_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/auction_entities.dart';
import '../../domain/repositories/base_auction_repository.dart';
import '../data_source/auction_reomte_data_source.dart';

class AuctionRepository extends BaseAuctionRepository {
  AuctionRepository(this.baseAuctionRemoteDataSource);
  final BaseAuctionRemoteDataSource baseAuctionRemoteDataSource;

  @override
  Future<Either<Failure, String>> deleteAuction(
      String userToken, String productId) async {
    final String result =
        await baseAuctionRemoteDataSource.deleteAuction(userToken, productId);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<AuctionEntities>>> getAuctionProducts() async {
    final List<AuctionEntities> result =
        await baseAuctionRemoteDataSource.getAuctionProducts();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<AuctionEntities>>> getAuctionProductsSearchResult(
      SearchQueryEntity searchQueryEntity) async {
    final List<AuctionEntities> result = await baseAuctionRemoteDataSource
        .getAuctionProductsSearchResult(searchQueryEntity);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> uploadAuctionProduct(
      AuctionEntities auctionProduct, String userToken) async {
    final String result = await baseAuctionRemoteDataSource
        .uploadAuctionProduct(auctionProduct, userToken);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, AuctionEntities>> viewAuctionData(
      String auctionId) async {
    final AuctionEntities result =
        await baseAuctionRemoteDataSource.viewAuctionDataById(auctionId);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> bidAuction({
    required String userToken,
    required String auctionId,
    required int pidAmount,
  }) async {
    final String result = await baseAuctionRemoteDataSource.bidAuction(
        auctionId: auctionId, bidAmount: pidAmount, userToken: userToken);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
