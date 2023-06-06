part of 'report_furniture_bloc.dart';

class ReportFurnitureEvent extends Equatable {
  const ReportFurnitureEvent({
    required this.productId,
    required this.accessToken,
    required this.report,
  });

  final String productId;
  final String accessToken;
  final ReportEntity report;

  @override
  List<Object> get props => [productId, accessToken, report];
}
