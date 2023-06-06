part of 'get_conversation_bloc.dart';

class GetConversationEvent extends Equatable {
  final String userId;
  final String accessToken;

  const GetConversationEvent({
    required this.accessToken,
    required this.userId,
  });

  @override
  List<Object> get props => [
        userId,
        accessToken,
      ];
}
