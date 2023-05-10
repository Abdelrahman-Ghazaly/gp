part of 'log_in_bloc.dart';

abstract class LogInEvent extends Equatable {
  const LogInEvent();

  @override
  List<Object> get props => [];
}

class PostDataEvent extends LogInEvent {
  final String email;
  final String password;

  const PostDataEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
