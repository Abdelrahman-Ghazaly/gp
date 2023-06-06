part of 'report_furniture_bloc.dart';

abstract class ReportFurnitureState extends Equatable {
  const ReportFurnitureState();

  @override
  List<Object> get props => [];
}

class Empty extends ReportFurnitureState {}

class Loading extends ReportFurnitureState {}

class Success extends ReportFurnitureState {
  final String message;

  const Success({required this.message});

  @override
  List<Object> get props => [message];
}

class Error extends ReportFurnitureState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
