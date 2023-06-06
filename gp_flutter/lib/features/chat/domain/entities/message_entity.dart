class MessageEntity {
  final String senderId;
  final String message;
  final String createdAt;
  final String conversationId;

  MessageEntity({
    required this.senderId,
    required this.message,
    required this.createdAt,
    required this.conversationId,
  });
}
