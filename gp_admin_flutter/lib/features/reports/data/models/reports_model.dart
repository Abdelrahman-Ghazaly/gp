import 'package:gp_admin_flutter/features/reports/data/models/furniture_model.dart';
import 'package:gp_admin_flutter/features/reports/domain/entities/report_entity.dart';

class ReportsModel extends ReportEntity {
  const ReportsModel(
      {required super.reportType,
      required super.description,
      required super.id,
      required super.furnitureEntity});
  factory ReportsModel.fromJson(Map<String, dynamic> json) => ReportsModel(
        reportType: json['report_type'] ?? "",
        description: json['description'] ?? "",
        furnitureEntity: FurnitureModel.fromMap(json['product_id']),
        id: json['_id'] ?? "",
      );
}
