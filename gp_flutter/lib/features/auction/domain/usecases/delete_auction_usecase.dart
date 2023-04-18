import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/base_auction_repository.dart';

class DeleteAuctionUseCase extends BaseUseCase<int, String> {
  final BaseAuctionRepository baseAuctionRepository;

  DeleteAuctionUseCase(this.baseAuctionRepository);
  @override
  Future<Either<Failure, int>> call(String params) {
    return baseAuctionRepository.deleteAuction(params);
  }
}
