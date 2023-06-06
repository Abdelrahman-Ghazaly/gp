import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';

import '../repositories/chat_repository.dart';

class SendMessage extends BaseUseCase<void, Params> {
  final ChatRepository repository;

  SendMessage({required this.repository});

  @override
  Future<Either<Failure, void>> call(Params params) {
    return repository.sendMessage(
      message: params.message,
      conversationId: params.conversationId,
      userId: params.userId,
      accessToken: params.accessToken,
    );
  }
}

class Params extends Equatable {
  final String message;
  final String conversationId;
  final String userId;
  final String accessToken;

  const Params({
    required this.message,
    required this.conversationId,
    required this.userId,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [
        message,
        conversationId,
        userId,
        accessToken,
      ];
}
