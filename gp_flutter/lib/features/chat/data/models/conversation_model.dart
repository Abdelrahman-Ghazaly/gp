import 'package:gp_flutter/features/chat/domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  const ConversationModel({
    required super.conversationId,
    required super.recieverId,
    required super.senderId,
  });

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      conversationId: map['_id'],
      senderId: map['members'][0],
      recieverId: map['members'][1],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
    };
  }
}
