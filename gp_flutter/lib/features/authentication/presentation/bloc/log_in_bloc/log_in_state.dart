part of 'log_in_bloc.dart';

abstract class LogInState extends Equatable {
  const LogInState();

  @override
  List<Object> get props => [];
}

class Empty extends LogInState {}

class Loading extends LogInState {}

class Success extends LogInState {
  final UserEntity userEntity;

  const Success({
    required this.userEntity,
  });

  @override
  List<Object> get props => [userEntity];
}

class Error extends LogInState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
