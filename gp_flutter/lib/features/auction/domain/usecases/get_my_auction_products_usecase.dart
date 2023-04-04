import 'package:dartz/dartz.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/features/auction/domain/entities/auction_product.dart';
import 'package:gp_flutter/features/auction/domain/repositories/base_auction_repository.dart';

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
