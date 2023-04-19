import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/auction_entities.dart';
import '../repositories/base_auction_repository.dart';

class GetAuctionProductsUseCase
    extends BaseUseCase<List<AuctionEntities>, NoParams> {
  final BaseAuctionRepository baseAuctionRepository;

  GetAuctionProductsUseCase(this.baseAuctionRepository);

  @override
  Future<Either<Failure, List<AuctionEntities>>> call(NoParams params) {
    return baseAuctionRepository.getAuctionProducts();
  }
}
