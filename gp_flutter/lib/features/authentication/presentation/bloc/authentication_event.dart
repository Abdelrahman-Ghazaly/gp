part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LogInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const LogInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends AuthenticationEvent {
  final UserModel userModel;

  const SignUpEvent({
    required this.userModel,
  });

  @override
  List<Object> get props => [userModel];
}
