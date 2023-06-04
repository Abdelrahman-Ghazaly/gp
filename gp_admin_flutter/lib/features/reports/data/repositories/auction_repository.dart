import 'package:dartz/dartz.dart';
import 'package:gp_admin_flutter/features/reports/data/datasources/report_reomte_data_source.dart';
import 'package:gp_admin_flutter/features/reports/domain/entities/report_entity.dart';
import 'package:gp_admin_flutter/features/reports/domain/repositories/base_report_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';

class ReportsRepository extends BaseReportRepository {
  final BaseReportRemoteDataSource baseReportRemoteDataSource;

  ReportsRepository(this.baseReportRemoteDataSource);

  @override
  Future<Either<Failure, List<ReportEntity>>> getReports(
      String adminToken) async {
    final result = await baseReportRemoteDataSource.getReports(adminToken);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> acceptReport(
      String productId, String adminToken) async {
    final result = await baseReportRemoteDataSource.acceptReportProduct(
        productId, adminToken);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> refuseReport(
      String adminToken, String productId) async {
    final result = await baseReportRemoteDataSource.refuseReportProduct(
      productId,
      adminToken,
    );
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
