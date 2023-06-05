import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';
import 'package:gp_flutter/features/chat/domain/repositories/chat_repository.dart';

class GetUserName extends BaseUseCase<String, Params> {
  final ChatRepository repository;
  GetUserName({required this.repository});

  @override
  Future<Either<Failure, String>> call(Params params) {
    return repository.getUserName(userId: params.userId);
  }
}

class Params extends Equatable {
  final String userId;

  const Params({required this.userId});

  @override
  List<Object?> get props => [userId];
}
