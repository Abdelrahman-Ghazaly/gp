import 'package:dartz/dartz.dart';
import 'package:gp_flutter/features/chat/domain/entities/conversation_entity.dart';
import 'package:gp_flutter/features/chat/domain/entities/message_entity.dart';

import '../../../../core/error/failure.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ConversationEntity>>> getConversations({
    required String userId,
    required String accessToken,
  });

  Future<Either<Failure, List<MessageEntity>>> getMessages({
    required String conversationId,
    required String accessToken,
  });

  Future<Either<Failure, String>> createConversation({
    required String userId,
    required String receiverId,
    required String accessToken,
  });

  Future<Either<Failure, String>> getUserName({required String userId});

  Future<Either<Failure, void>> sendMessage({
    required String message,
    required String conversationId,
    required String userId,
    required String accessToken,
  });
}
