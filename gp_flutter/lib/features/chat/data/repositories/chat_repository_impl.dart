import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';

import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/features/chat/data/data_sources/chat_remote_data_source.dart';

import 'package:gp_flutter/features/chat/domain/entities/conversation_entity.dart';

import 'package:gp_flutter/features/chat/domain/entities/message_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, String>> createConversation({
    required String userId,
    required String receiverId,
    required String accessToken,
  }) async {
    try {
      final result = await remoteDataSource.createConversation(
        userId: userId,
        receiverId: receiverId,
        accessToken: accessToken,
      );
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<ConversationEntity>>> getConversations({
    required String userId,
    required String accessToken,
  }) async {
    try {
      final result = await remoteDataSource.getConversations(
        userId: userId,
        accessToken: accessToken,
      );
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getMessages({
    required String conversationId,
    required String accessToken,
  }) async {
    try {
      final result = await remoteDataSource.getMessages(
        conversationId: conversationId,
        accessToken: accessToken,
      );
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required String message,
    required String conversationId,
    required String userId,
    required String accessToken,
  }) async {
    try {
      final result = await remoteDataSource.sendMessage(
        message: message,
        conversationId: conversationId,
        userId: userId,
        accessToken: accessToken,
      );
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> getUserName({required String userId}) async {
    try {
      final result = await remoteDataSource.getUserName(userId: userId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
