part of 'get_messages_bloc.dart';

class GetMessagesEvent extends Equatable {
  final String conversationId;
  final String accessToken;

  const GetMessagesEvent({
    required this.conversationId,
    required this.accessToken,
  });

  @override
  List<Object> get props => [
        conversationId,
        accessToken,
      ];
}
