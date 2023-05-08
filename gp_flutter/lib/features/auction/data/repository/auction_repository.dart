import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/auction_entities.dart';
import '../../domain/repositories/base_auction_repository.dart';
import '../data_source/auction_reomte_data_source.dart';

class AuctionRepository extends BaseAuctionRepository {
  final BaseAuctionRemoteDataSource baseAuctionRemoteDataSource;

  AuctionRepository(this.baseAuctionRemoteDataSource);

  @override
  Future<Either<Failure, int>> deleteAuction(
      String userToken, String productId) async {
    final result =
        await baseAuctionRemoteDataSource.deleteAuction(userToken, productId);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<AuctionEntities>>> getAuctionProducts() async {
    final result = await baseAuctionRemoteDataSource.getAuctionProducts();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<AuctionEntities>>> getAuctionProductsSearchResult(
      searchQueryEntity) async {
    final result = await baseAuctionRemoteDataSource
        .getAuctionProductsSearchResult(searchQueryEntity);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, int>> uploadAuctionProduct(
      AuctionEntities auctionProduct, String userToken) async {
    final result = await baseAuctionRemoteDataSource.uploadAuctionProduct(
        auctionProduct, userToken);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, AuctionEntities>> viewAuctionData(
      String auctionId) async {
    final result =
        await baseAuctionRemoteDataSource.viewAuctionDataById(auctionId);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
