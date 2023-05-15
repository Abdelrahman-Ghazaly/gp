import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/base_auction_repository.dart';

class BidAuctionUseCase extends BaseUseCase<String, Params> {
  final BaseAuctionRepository baseAuctionRepository;

  BidAuctionUseCase(this.baseAuctionRepository);
  @override
  Future<Either<Failure, String>> call(Params params) {
    return baseAuctionRepository.bidAuction(
      auctionId: params.productId,
      userToken: params.userId,
      pidAmount: params.bidAmount,
    );
  }
}

class Params extends Equatable {
  final String userId;
  final String productId;
  final int bidAmount;

  const Params(
      {required this.bidAmount, required this.userId, required this.productId});

  @override
  List<Object?> get props => [userId, productId, bidAmount];
}
