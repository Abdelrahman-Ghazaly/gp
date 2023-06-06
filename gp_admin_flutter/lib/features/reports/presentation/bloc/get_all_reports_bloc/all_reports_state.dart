// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'all_reports_bloc.dart';

abstract class AllReportsState extends Equatable {
  const AllReportsState();

  @override
  List<Object> get props => [];
}

class Loading extends AllReportsState {}

class Empty extends AllReportsState {}

class Loaded extends AllReportsState {
  final List<ReportEntity> reportList;

  const Loaded({
    required this.reportList,
  });

  @override
  List<Object> get props => [reportList];
}

class Error extends AllReportsState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
