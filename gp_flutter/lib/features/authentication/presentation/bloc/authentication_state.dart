part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Empty extends AuthenticationState {}

class Loading extends AuthenticationState {}

class SignedUpSuccessfully extends AuthenticationState {}

class LoggedInSuccessfully extends AuthenticationState {
  final UserEntity userEntity;

  const LoggedInSuccessfully({
    required this.userEntity,
  });

  @override
  List<Object> get props => [userEntity];
}

class Error extends AuthenticationState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
