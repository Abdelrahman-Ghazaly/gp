import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/auction_entities.dart';
import '../entities/search_query_entity.dart';
import '../repositories/base_auction_repository.dart';

class GetAuctionProductsSearchResultUseCase
    extends BaseUseCase<List<AuctionEntities>, Params> {
  final BaseAuctionRepository baseAuctionRepository;

  GetAuctionProductsSearchResultUseCase(this.baseAuctionRepository);

  @override
  Future<Either<Failure, List<AuctionEntities>>> call(Params params) {
    return baseAuctionRepository
        .getAuctionProductsSearchResult(params.searchQueryEntity);
  }
}

class Params extends Equatable {
  final SearchQueryEntity searchQueryEntity;

  const Params({required this.searchQueryEntity});

  @override
  List<Object?> get props => [searchQueryEntity];
}
