import 'package:equatable/equatable.dart';
import 'package:gp_admin_flutter/features/reports/domain/entities/furniture_entity.dart';

class ReportEntity extends Equatable {
  final String id;
  final String reportType;
  final String description;
  final FurnitureEntity furnitureEntity;

  const ReportEntity({
    required this.id,
    required this.reportType,
    required this.description,
    required this.furnitureEntity,
  });

  @override
  List<Object?> get props => [reportType, description, id, furnitureEntity];
}
