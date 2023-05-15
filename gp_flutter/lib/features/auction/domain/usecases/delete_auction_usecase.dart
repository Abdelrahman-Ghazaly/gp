import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/base_auction_repository.dart';

class DeleteAuctionUseCase extends BaseUseCase<String, Params> {
  final BaseAuctionRepository baseAuctionRepository;

  DeleteAuctionUseCase(this.baseAuctionRepository);
  @override
  Future<Either<Failure, String>> call(Params params) {
    return baseAuctionRepository.deleteAuction(
        params.userToken, params.productId);
  }
}

class Params extends Equatable {
  final String userToken;
  final String productId;

  const Params({required this.userToken, required this.productId});

  @override
  List<Object?> get props => [userToken, productId];
}
