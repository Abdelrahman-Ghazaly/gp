import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../data_source/auction_reomte_data_source.dart';
import '../../domain/entities/auction_product.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/base_auction_repository.dart';

class AuctionRepository extends BaseAuctionRepository {
  final BaseAuctionRemoteDataSource baseAuctionRemoteDataSource;

  AuctionRepository(this.baseAuctionRemoteDataSource);

  @override
  Future<Either<Failure, int>> deleteAuction(String userToken) async {
    final result = await baseAuctionRemoteDataSource.deleteAuction(userToken);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<AuctionProduct>>> getAuctionProducts() async {
    final result = await baseAuctionRemoteDataSource.getAuctionProducts();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<AuctionProduct>>>
      getAuctionProductsSearchResult() async {
    final result =
        await baseAuctionRemoteDataSource.getAuctionProductsSearchResult();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, int>> uploadAuctionProduct(
      AuctionProduct auctionProduct) async {
    final result =
        await baseAuctionRemoteDataSource.uploadAuctionProduct(auctionProduct);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}