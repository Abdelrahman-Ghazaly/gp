import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/auction_entities.dart';
import '../entities/search_query_entity.dart';

abstract class BaseAuctionRepository {
  Future<Either<Failure, List<AuctionEntities>>> getAuctionProducts();
  Future<Either<Failure, AuctionEntities>> viewAuctionData(String auctionId);
  Future<Either<Failure, List<AuctionEntities>>> getAuctionProductsSearchResult(
      SearchQueryEntity searchQueryEntity);

  Future<Either<Failure, int>> uploadAuctionProduct(
      AuctionEntities auctionProduct);

  Future<Either<Failure, int>> deleteAuction(String userToken);
}
