part of 'request_report_bloc.dart';

abstract class RequestReportState extends Equatable {
  const RequestReportState();

  @override
  List<Object> get props => [];
}

class Empty extends RequestReportState {}

class Loading extends RequestReportState {}

class Success extends RequestReportState {
  final String message;

  const Success({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class Error extends RequestReportState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
