import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/auction_entities.dart';

abstract class BaseAuctionRepository {
  Future<Either<Failure, List<AuctionEntities>>> getAuctionProducts(
      String adminToken);

  Future<Either<Failure, String>> acceptAuction(
      String productId, String adminToken);

  Future<Either<Failure, String>> refuseAuction(
      String adminToken, String productId);
}
