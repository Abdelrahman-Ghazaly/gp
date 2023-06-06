import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_flutter/features/chat/domain/usecases/get_user_name.dart';

import '../../../../../core/error/failure.dart';

part 'get_user_name_event.dart';
part 'get_user_name_state.dart';

class GetUserNameBloc extends Bloc<GetUserNameEvent, GetUserNameState> {
  final GetUserName getUserName;

  GetUserNameBloc({required this.getUserName}) : super(Empty()) {
    on<GetUserNameEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrSuccess = await getUserName(
          Params(
            userId: event.userId,
          ),
        );
        emit(await _eitherErrorOrSuccess(failureOrSuccess));
      },
    );
  }
  Future<GetUserNameState> _eitherErrorOrSuccess(
    Either<Failure, String> failureOrString,
  ) async {
    return failureOrString.fold(
      (failure) => Error(message: failure.message),
      (name) => Success(name: name),
    );
  }
}
