import 'package:dio/dio.dart';
import 'package:gp_admin_flutter/features/reports/data/models/reports_model.dart';
import 'package:gp_admin_flutter/features/reports/domain/entities/report_entity.dart';

import '../../../../core/app_constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/error_message_model.dart';

abstract class BaseReportRemoteDataSource {
  Future<List<ReportEntity>> getReports(String adminToken);

  Future<String> acceptReportProduct(String reportId, String adminToken);
  Future<String> refuseReportProduct(String reportId, String adminToken);
}

class ReportRemoteDataSource extends BaseReportRemoteDataSource {
  final Dio dio;

  ReportRemoteDataSource({required this.dio});
  @override
  Future<List<ReportEntity>> getReports(String adminToken) async {
    Response response = await dio.get(ApiConstants.auctionViewRequestsPath,
        options: Options(
          followRedirects: false,
          headers: {
            'token': "bearer $adminToken",
          },
        ));

    if (response.statusCode == 200) {
      return List.from(
        (response.data).map((element) => ReportsModel.fromJson(element)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<String> acceptReportProduct(String reportId, String adminToken) async {
    Response response = await dio.put(
      ApiConstants.acceptReportPath(
        reportId,
      ),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: {
          'token': "bearer $adminToken",
        },
      ),
    );
    if (response.statusCode == 200) {
      return 'Accepted Succesfully';
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<String> refuseReportProduct(String reportId, String adminToken) async {
    Response response = await dio.delete(
      ApiConstants.refuseReportPath(
        reportId,
      ),
      options: Options(
        followRedirects: false,
        headers: {
          'token': "bearer $adminToken",
        },
      ),
    );
    if (response.statusCode == 200) {
      return 'Deleted Succesfully';
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
