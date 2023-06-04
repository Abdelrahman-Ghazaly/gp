import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/base_report_repository.dart';

class RefuseReportUseCase extends BaseUseCase<String, Params> {
  final BaseReportRepository baseAuctionRepository;

  RefuseReportUseCase(this.baseAuctionRepository);
  @override
  Future<Either<Failure, String>> call(Params params) {
    return baseAuctionRepository.refuseReport(
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
