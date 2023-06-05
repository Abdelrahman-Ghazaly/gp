import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_flutter/features/chat/domain/entities/message_entity.dart';
import 'package:gp_flutter/features/chat/domain/usecases/get_messages.dart';

import '../../../../../core/error/failure.dart';

part 'get_messages_event.dart';
part 'get_messages_state.dart';

class GetMessagesBloc extends Bloc<GetMessagesEvent, GetMessagesState> {
  final GetMessages getMessages;

  GetMessagesBloc({required this.getMessages}) : super(Empty()) {
    on<GetMessagesEvent>((event, emit) async {
      emit(Loading());
      final failureOrSuccess = await getMessages(
        Params(
          conversationId: event.conversationId,
          accessToken: event.accessToken,
        ),
      );
      emit(await _eitherFailureOrSuccess(failureOrSuccess));
    });
  }

  Future<GetMessagesState> _eitherFailureOrSuccess(
    Either<Failure, List<MessageEntity>> failureOrSuccess,
  ) async {
    return failureOrSuccess.fold(
      (failure) => Error(message: failure.message),
      (messages) => Success(messages: messages),
    );
  }
}
