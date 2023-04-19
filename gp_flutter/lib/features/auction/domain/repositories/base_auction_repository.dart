import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/auction_entities.dart';

abstract class BaseAuctionRepository {
  Future<Either<Failure, List<AuctionEntities>>> getAuctionProducts();
  Future<Either<Failure, AuctionEntities>> viewAuctionData();
  Future<Either<Failure, List<AuctionEntities>>>
      getAuctionProductsSearchResult();

  Future<Either<Failure, int>> uploadAuctionProduct(
      AuctionEntities auctionProduct);

  Future<Either<Failure, int>> deleteAuction(String userToken);
}
