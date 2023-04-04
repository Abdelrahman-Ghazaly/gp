import 'package:dartz/dartz.dart';
import '../entities/auction_product.dart';

import '../../../../core/error/failure.dart';

abstract class BaseAuctionRepository {
  Future<Either<Failure, List<AuctionProduct>>> getAuctionProducts();

  Future<Either<Failure, List<AuctionProduct>>> getMyAuctionProducts();

  Future<Either<Failure, List<AuctionProduct>>>
      getAuctionProductsSearchResult();
}
