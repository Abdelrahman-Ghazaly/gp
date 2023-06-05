part of 'get_user_name_bloc.dart';

abstract class GetUserNameState extends Equatable {
  const GetUserNameState();

  @override
  List<Object> get props => [];
}

class Empty extends GetUserNameState {}

class Loading extends GetUserNameState {}

class Success extends GetUserNameState {
  final String name;

  const Success({required this.name});

  @override
  List<Object> get props => [name];
}

class Error extends GetUserNameState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
