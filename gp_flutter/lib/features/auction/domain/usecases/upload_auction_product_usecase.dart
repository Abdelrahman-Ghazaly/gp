import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/auction_product.dart';

import '../repositories/base_auction_repository.dart';

class UploadAuctionProductUseCase extends BaseUseCase<int, AuctionProduct> {
  final BaseAuctionRepository baseAuctionRepository;

  UploadAuctionProductUseCase(this.baseAuctionRepository);

  @override
  Future<Either<Failure, int>> call(AuctionProduct params) {
    return baseAuctionRepository.uploadAuctionProduct(params);
  }
}
