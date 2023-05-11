import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/base_auction_repository.dart';

class RefuseAuctionUseCase extends BaseUseCase<int, Params> {
  final BaseAuctionRepository baseAuctionRepository;

  RefuseAuctionUseCase(this.baseAuctionRepository);
  @override
  Future<Either<Failure, int>> call(Params params) {
    return baseAuctionRepository.refuseAuction(
        params.adminToken, params.productId);
  }
}

class Params extends Equatable {
  final String adminToken;
  final String productId;

  const Params({required this.adminToken, required this.productId});

  @override
  List<Object?> get props => [adminToken, productId];
}
