import 'package:dartz/dartz.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';

import '../repository/base_auction_repository.dart';

class DeleteAuctionUseCase extends BaseUseCase<int , String>{
  final BaseAuctionRepository baseAuctionRepository;

  DeleteAuctionUseCase(this.baseAuctionRepository);
  @override
  Future<Either<Failure, int>> call(String params) {
   return baseAuctionRepository.deleteAuction(params);
  }
}