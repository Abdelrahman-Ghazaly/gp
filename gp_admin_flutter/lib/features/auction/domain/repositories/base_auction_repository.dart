import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/auction_entities.dart';

abstract class BaseAuctionRepository {
  Future<Either<Failure, List<AuctionEntities>>> getAuctionProducts();
  Future<Either<Failure, AuctionEntities>> viewAuctionData(String auctionId);

  Future<Either<Failure, int>> acceptAuction(
      String productId, String adminToken);

  Future<Either<Failure, int>> refuseAuction(
      String adminToken, String productId);
}
