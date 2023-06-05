import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_flutter/features/chat/domain/usecases/send_message.dart';

import '../../../../../core/error/failure.dart';

part 'send_message_event.dart';
part 'send_message_state.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  final SendMessage sendMessage;
  SendMessageBloc({
    required this.sendMessage,
  }) : super(Empty()) {
    on<SendMessageEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrSuccess = await sendMessage(
          Params(
            conversationId: event.conversationId,
            accessToken: event.accessToken,
            message: event.message,
            userId: event.userId,
          ),
        );
        emit(await _eitherErrorOrSuccess(failureOrSuccess));
      },
    );
  }
  Future<SendMessageState> _eitherErrorOrSuccess(
    Either<Failure, void> failureOrString,
  ) async {
    return failureOrString.fold(
      (failure) => Error(message: failure.message),
      (_) => Success(),
    );
  }
}
