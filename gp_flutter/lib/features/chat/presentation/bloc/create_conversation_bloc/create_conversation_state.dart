part of 'create_conversation_bloc.dart';

abstract class CreateConversationState extends Equatable {
  const CreateConversationState();

  @override
  List<Object> get props => [];
}

class Empty extends CreateConversationState {}

class Loading extends CreateConversationState {}

class Success extends CreateConversationState {
  final String conversationId;

  const Success({required this.conversationId});

  @override
  List<Object> get props => [conversationId];
}

class Error extends CreateConversationState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
