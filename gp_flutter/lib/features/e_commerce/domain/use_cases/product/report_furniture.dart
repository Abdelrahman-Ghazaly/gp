import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';
import 'package:gp_flutter/features/e_commerce/domain/repositories/e_commerce_repository.dart';

import '../../entities/report_entity.dart';

class ReportFurniture extends BaseUseCase<String, Params> {
  final ECommerceRepository repository;

  ReportFurniture({required this.repository});

  @override
  Future<Either<Failure, String>> call(Params params) {
    return repository.reportFurniture(
      productId: params.productId,
      accessToken: params.accessToken,
      report: params.report,
    );
  }
}

class Params extends Equatable {
  final String productId;
  final String accessToken;
  final ReportEntity report;

  const Params(
      {required this.productId,
      required this.accessToken,
      required this.report});

  @override
  List<Object?> get props => [productId, accessToken, report];
}
