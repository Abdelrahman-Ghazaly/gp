part of 'get_messages_bloc.dart';

abstract class GetMessagesState extends Equatable {
  const GetMessagesState();

  @override
  List<Object> get props => [];
}

class Empty extends GetMessagesState {}

class Loading extends GetMessagesState {}

class Success extends GetMessagesState {
  final List<MessageEntity> messages;

  const Success({required this.messages});

  @override
  List<Object> get props => [messages];
}

class Error extends GetMessagesState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
