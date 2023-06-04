import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';
import 'package:gp_flutter/features/chat/domain/entities/conversation_entity.dart';
import 'package:gp_flutter/features/chat/domain/repositories/chat_repository.dart';

class GetConversation extends BaseUseCase<List<ConversationEntity>, Params> {
  final ChatRepository repository;

  GetConversation({required this.repository});

  @override
  Future<Either<Failure, List<ConversationEntity>>> call(Params params) {
    return repository.getConversations(userId: params.userId);
  }
}

class Params extends Equatable {
  final String userId;

  const Params({required this.userId});

  @override
  List<Object?> get props => [userId];
}
