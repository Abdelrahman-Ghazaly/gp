import 'package:dartz/dartz.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';
import 'package:gp_flutter/features/auction/domain/entities/auction_product.dart';

import '../repository/base_auction_repository.dart';

class UploadAuctionProduct extends BaseUseCase<int, AuctionProduct> {
  final BaseAuctionRepository baseAuctionRepository;

  UploadAuctionProduct(this.baseAuctionRepository);

  @override
  Future<Either<Failure, int>> call(AuctionProduct params) {
    return baseAuctionRepository.uploadAuctionProduct(params);
  }
}
