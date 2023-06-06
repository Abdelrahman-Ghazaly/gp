import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/report_entity.dart';

abstract class BaseReportRepository {
  Future<Either<Failure, List<ReportEntity>>> getReports(String adminToken);

  Future<Either<Failure, String>> acceptReport(
      String productId, String adminToken);

  Future<Either<Failure, String>> refuseReport(
      String adminToken, String productId);
}
