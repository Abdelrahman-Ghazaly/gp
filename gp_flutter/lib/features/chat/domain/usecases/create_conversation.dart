import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';
import 'package:gp_flutter/features/chat/domain/repositories/chat_repository.dart';

class CreateConversation extends BaseUseCase<void, Params> {
  ChatRepository repository;

  CreateConversation({required this.repository});

  @override
  Future<Either<Failure, String>> call(Params params) {
    return repository.createConversation(
      userId: params.userId,
      receiverId: params.receiverId,
      accessToken: params.accessToken,
    );
  }
}

class Params extends Equatable {
  final String userId;
  final String receiverId;
  final String accessToken;

  const Params({
    required this.userId,
    required this.receiverId,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [
        userId,
        receiverId,
        accessToken,
      ];
}
