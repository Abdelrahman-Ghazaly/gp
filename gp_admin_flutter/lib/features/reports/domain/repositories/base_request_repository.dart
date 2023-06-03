import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/auction_entities.dart';

abstract class BaseRequestRepository {
  Future<Either<Failure, List<AuctionEntities>>> getAuctionProducts(
      String adminToken);

  Future<Either<Failure, String>> acceptRequest(
      String productId, String adminToken);

  Future<Either<Failure, String>> refuseRequest(
      String adminToken, String productId);
}
