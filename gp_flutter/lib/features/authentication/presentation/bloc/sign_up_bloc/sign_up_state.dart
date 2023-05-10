part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class Empty extends SignUpState {}

class Loading extends SignUpState {}

class Success extends SignUpState {}

class Error extends SignUpState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
