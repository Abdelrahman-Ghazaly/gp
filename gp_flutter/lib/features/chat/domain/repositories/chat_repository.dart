import 'package:dartz/dartz.dart';
import 'package:gp_flutter/features/chat/domain/entities/conversation_entity.dart';
import 'package:gp_flutter/features/chat/domain/entities/message_entity.dart';

import '../../../../core/error/failure.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ConversationEntity>>> getConversations({
    required String userId,
  });

  Future<Either<Failure, List<MessageEntity>>> getMessages({
    required String conversationId,
  });

  Future<Either<Failure, void>> createConversation({
    required String userId,
    required String receiverId,
  });

  Future<Either<Failure, void>> sendMessage({
    required String message,
    required String conversationId,
    required String userId,
  });
}
