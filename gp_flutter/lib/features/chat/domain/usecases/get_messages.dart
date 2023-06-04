import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';
import 'package:gp_flutter/features/chat/domain/entities/message_entity.dart';

import '../repositories/chat_repository.dart';

class GetMessages extends BaseUseCase<List<MessageEntity>, Params> {
  final ChatRepository repository;

  GetMessages({required this.repository});

  @override
  Future<Either<Failure, List<MessageEntity>>> call(Params params) {
    return repository.getMessages(conversationId: params.conversationId);
  }
}

class Params extends Equatable {
  final String conversationId;

  const Params({required this.conversationId});

  @override
  List<Object?> get props => [conversationId];
}
