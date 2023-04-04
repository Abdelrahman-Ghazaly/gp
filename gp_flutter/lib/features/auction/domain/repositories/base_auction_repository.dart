import 'package:dartz/dartz.dart';
import 'package:gp_flutter/features/auction/domain/entities/auction_product.dart';

import '../../../../core/error/failure.dart';

abstract class BaseAuctionRepository {
  Future<Either<Failure, List<AuctionProduct>>> getAuctionProducts();

  Future<Either<Failure, List<AuctionProduct>>> getMyAuctionProducts();

  Future<Either<Failure, List<AuctionProduct>>>
      getAuctionProductsSearchResult();
}
