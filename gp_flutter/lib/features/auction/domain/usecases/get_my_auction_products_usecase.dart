import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/auction_product.dart';
import '../repositories/base_auction_repository.dart';

import '../../../../core/use_case/use_case.dart';

class GetMyAuctionProductsUseCase
    extends BaseUseCase<List<AuctionProduct>, NoParams> {
  final BaseAuctionRepository baseAuctionRepository;

  GetMyAuctionProductsUseCase(this.baseAuctionRepository);

  @override
  Future<Either<Failure, List<AuctionProduct>>> call(NoParams params) {
    return baseAuctionRepository.getMyAuctionProducts();
  }
}
