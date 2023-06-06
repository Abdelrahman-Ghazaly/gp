part of 'all_reports_bloc.dart';

abstract class AllReportsEvent extends Equatable {
  const AllReportsEvent();

  @override
  List<Object> get props => [];
}

class GetReportsEvent extends AllReportsEvent {
  final String adminToken;

  const GetReportsEvent({required this.adminToken});
}

class UpdateReportsList extends AllReportsEvent {
  final List<ReportEntity> reportList;

  const UpdateReportsList({required this.reportList});
}
