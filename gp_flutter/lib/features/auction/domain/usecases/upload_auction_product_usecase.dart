import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/auction_entities.dart';
import '../repositories/base_auction_repository.dart';

class UploadAuctionProductUseCase extends BaseUseCase<String, Params> {
  final BaseAuctionRepository baseAuctionRepository;

  UploadAuctionProductUseCase(this.baseAuctionRepository);

  @override
  Future<Either<Failure, String>> call(Params params) {
    return baseAuctionRepository.uploadAuctionProduct(
        params.auctionEntities, params.userToken);
  }
}

class Params extends Equatable {
  final String userToken;
  final AuctionEntities auctionEntities;

  const Params({required this.userToken, required this.auctionEntities});

  @override
  List<Object?> get props => [userToken, auctionEntities];
}
