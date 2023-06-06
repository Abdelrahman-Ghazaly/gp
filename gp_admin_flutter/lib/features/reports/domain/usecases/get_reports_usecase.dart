import 'package:dartz/dartz.dart';
import 'package:gp_admin_flutter/features/reports/domain/entities/report_entity.dart';
import 'package:gp_admin_flutter/features/reports/domain/repositories/base_report_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';

class GetReportsUseCase extends BaseUseCase<List<ReportEntity>, String> {
  final BaseReportRepository baseReportRepository;

  GetReportsUseCase(this.baseReportRepository);

  @override
  Future<Either<Failure, List<ReportEntity>>> call(String params) {
    return baseReportRepository.getReports(params);
  }
}
