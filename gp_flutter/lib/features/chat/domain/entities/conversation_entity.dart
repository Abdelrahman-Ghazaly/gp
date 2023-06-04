import 'package:equatable/equatable.dart';

class ConversationEntity extends Equatable {
  final String conversationId;
  final String senderId;
  final String recieverId;

  const ConversationEntity({
    required this.conversationId,
    required this.senderId,
    required this.recieverId,
  });

  @override
  List<Object?> get props => [
        conversationId,
        senderId,
        recieverId,
      ];
}
