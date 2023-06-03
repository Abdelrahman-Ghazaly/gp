import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/base_request_repository.dart';

class AcceptRequestUseCase extends BaseUseCase<String, Params> {
  final BaseAuctionRepository baseAuctionRepository;

  AcceptRequestUseCase(this.baseAuctionRepository);
  @override
  Future<Either<Failure, String>> call(Params params) {
    return baseAuctionRepository.acceptAuction(
      params.productId,
      params.adminToken,
    );
  }
}

class Params extends Equatable {
  final String adminToken;
  final String productId;

  const Params({required this.adminToken, required this.productId});

  @override
  List<Object?> get props => [adminToken, productId];
}
