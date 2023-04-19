import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/auction_entities.dart';
import '../repositories/base_auction_repository.dart';

class ViewAuctionDataUseCase
    extends BaseUseCase<AuctionEntities, NoParams> {
  final BaseAuctionRepository baseAuctionRepository;

  ViewAuctionDataUseCase(this.baseAuctionRepository);

  @override
  Future<Either<Failure, AuctionEntities>> call(NoParams params) {
    return baseAuctionRepository.viewAuctionData();
  }
}
