part of 'request_report_bloc.dart';

abstract class RequestReportEvent extends Equatable {
  const RequestReportEvent();

  @override
  List<Object> get props => [];
}

class AcceptReportEvent extends RequestReportEvent {
  final String adminToken;
  final String auctionId;

  const AcceptReportEvent({required this.adminToken, required this.auctionId});
}

class RefuseReportEvent extends RequestReportEvent {
  final String adminToken;
  final String auctionId;

  const RefuseReportEvent({required this.adminToken, required this.auctionId});
}
