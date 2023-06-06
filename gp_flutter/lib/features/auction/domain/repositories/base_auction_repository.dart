import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/auction_entities.dart';
import '../entities/search_query_entity.dart';

abstract class BaseAuctionRepository {
  Future<Either<Failure, List<AuctionEntities>>> getAuctionProducts();
  Future<Either<Failure, AuctionEntities>> viewAuctionData(String auctionId);
  Future<Either<Failure, List<AuctionEntities>>> getAuctionProductsSearchResult(
      SearchQueryEntity searchQueryEntity);

  Future<Either<Failure, String>> uploadAuctionProduct(
      AuctionEntities auctionProduct, String userToken);

  Future<Either<Failure, String>> deleteAuction(
      String userToken, String productId);
  Future<Either<Failure, String>> bidAuction({
    required String userToken,
    required String auctionId,
    required int pidAmount,
  });
}
