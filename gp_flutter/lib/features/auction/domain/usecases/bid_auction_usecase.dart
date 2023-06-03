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
      auctionId: params.auctionId,
      userToken: params.userToken,
      pidAmount: params.bidAmount,
    );
  }
}

class Params extends Equatable {
  final String userToken;
  final String auctionId;
  final int bidAmount;

  const Params(
      {required this.bidAmount,
      required this.userToken,
      required this.auctionId});

  @override
  List<Object?> get props => [userToken, auctionId, bidAmount];
}
