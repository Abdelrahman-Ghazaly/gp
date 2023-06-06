import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_flutter/features/chat/domain/entities/conversation_entity.dart';
import 'package:gp_flutter/features/chat/domain/usecases/get_conversation.dart';

import '../../../../../core/error/failure.dart';

part 'get_conversation_event.dart';
part 'get_conversation_state.dart';

class GetConversationsBloc
    extends Bloc<GetConversationEvent, GetConversationState> {
  final GetConversations getConversation;
  GetConversationsBloc({required this.getConversation}) : super(Empty()) {
    on<GetConversationEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrSuccess = await getConversation(
          Params(
            userId: event.userId,
            accessToken: event.accessToken,
          ),
        );
        final state = await _eitherFailureOrSuccess(failureOrSuccess);
        if (state is Success && state.conversations.isEmpty) {
          emit(Empty());
        } else {
          emit(state);
        }
      },
    );
  }
  Future<GetConversationState> _eitherFailureOrSuccess(
    Either<Failure, List<ConversationEntity>> failureOrSuccess,
  ) async {
    return await failureOrSuccess.fold(
      (failure) => Error(message: failure.message),
      (conversations) => Success(conversations: conversations),
    );
  }
}
