part of 'create_conversation_bloc.dart';

class CreateConversationEvent extends Equatable {
  final String userId;
  final String receiverId;
  final String accessToken;

  const CreateConversationEvent(
      {required this.userId,
      required this.accessToken,
      required this.receiverId});

  @override
  List<Object> get props => [
        userId,
        receiverId,
        accessToken,
      ];
}
