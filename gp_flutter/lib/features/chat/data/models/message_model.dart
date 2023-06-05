import 'package:gp_flutter/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.message,
    required super.senderId,
    required super.createdAt,
    required super.conversationId,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      conversationId: map['conversationId'],
      message: map['text'],
      senderId: map['sender'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': message,
      'conversationId': conversationId,
    };
  }
}
