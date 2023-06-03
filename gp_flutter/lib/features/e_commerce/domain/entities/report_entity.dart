import 'package:equatable/equatable.dart';

class ReportEntity extends Equatable {
  final String reportType;
  final String description;

  const ReportEntity({
    required this.reportType,
    required this.description,
  });

  @override
  List<Object?> get props => [
        reportType,
        description,
      ];
}
