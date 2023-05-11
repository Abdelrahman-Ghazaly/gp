import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/auction_entities.dart';
import '../../domain/repositories/base_auction_repository.dart';

import '../datasources/auction_reomte_data_source.dart';

class AuctionRepository extends BaseAuctionRepository {
  final BaseAuctionRemoteDataSource baseAuctionRemoteDataSource;

  AuctionRepository(this.baseAuctionRemoteDataSource);

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

  @override
  Future<Either<Failure, int>> acceptAuction(
      String productId, String adminToken) async {
    final result = await baseAuctionRemoteDataSource.acceptAuctionProduct(
        productId, adminToken);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, int>> refuseAuction(
      String adminToken, String productId) async {
    final result = await baseAuctionRemoteDataSource.refuseAuctionProduct(
        productId, adminToken);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
