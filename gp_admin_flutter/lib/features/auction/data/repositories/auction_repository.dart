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
  Future<Either<Failure, List<AuctionEntities>>> getAuctionProducts(
      String adminToken) async {
    final result =
        await baseAuctionRemoteDataSource.getAuctionProducts(adminToken);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> acceptAuction(
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
  Future<Either<Failure, String>> refuseAuction(
      String adminToken, String productId) async {
    final result = await baseAuctionRemoteDataSource.refuseAuctionProduct(
      productId,
      adminToken,
    );
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
