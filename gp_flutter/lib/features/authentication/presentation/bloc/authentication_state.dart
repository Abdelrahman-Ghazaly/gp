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
  final UserCredentialsEntity userCredentialsEntity;

  const LoggedInSuccessfully({
    required this.userCredentialsEntity,
  });

  @override
  List<Object> get props => [userCredentialsEntity];
}

class Error extends AuthenticationState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
