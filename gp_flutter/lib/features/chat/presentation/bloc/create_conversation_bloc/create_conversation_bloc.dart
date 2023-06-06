import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_flutter/features/chat/domain/usecases/create_conversation.dart';

import '../../../../../core/error/failure.dart';

part 'create_conversation_event.dart';
part 'create_conversation_state.dart';

class CreateConversationBloc
    extends Bloc<CreateConversationEvent, CreateConversationState> {
  final CreateConversation createConversation;
  CreateConversationBloc({required this.createConversation}) : super(Empty()) {
    on<CreateConversationEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrSuccess = await createConversation(
          Params(
            accessToken: event.accessToken,
            userId: event.userId,
            receiverId: event.receiverId,
          ),
        );
        emit(await _eitherErrorOrSuccess(failureOrSuccess));
      },
    );
  }
  Future<CreateConversationState> _eitherErrorOrSuccess(
    Either<Failure, String> failureOrString,
  ) async {
    return failureOrString.fold(
      (failure) => Error(message: failure.message),
      (conversationId) => Success(conversationId: conversationId),
    );
  }
}
