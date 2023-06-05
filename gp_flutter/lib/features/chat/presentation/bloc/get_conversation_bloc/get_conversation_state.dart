part of 'get_conversation_bloc.dart';

abstract class GetConversationState extends Equatable {
  const GetConversationState();

  @override
  List<Object> get props => [];
}

class Empty extends GetConversationState {}

class Loading extends GetConversationState {}

class Success extends GetConversationState {
  final List<ConversationEntity> conversations;

  const Success({
    required this.conversations,
  });

  @override
  List<Object> get props => [conversations];
}

class Error extends GetConversationState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
