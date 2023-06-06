part of 'send_message_bloc.dart';

class SendMessageEvent extends Equatable {
  final String message;
  final String conversationId;
  final String userId;
  final String accessToken;

  const SendMessageEvent({
    required this.message,
    required this.conversationId,
    required this.userId,
    required this.accessToken,
  });

  @override
  List<Object> get props => [
        message,
        conversationId,
        userId,
        accessToken,
      ];
}
