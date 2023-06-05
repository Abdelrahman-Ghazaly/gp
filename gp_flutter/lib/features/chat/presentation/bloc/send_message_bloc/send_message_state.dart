part of 'send_message_bloc.dart';

abstract class SendMessageState extends Equatable {
  const SendMessageState();

  @override
  List<Object> get props => [];
}

class Empty extends SendMessageState {}

class Loading extends SendMessageState {}

class Success extends SendMessageState {}

class Error extends SendMessageState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
