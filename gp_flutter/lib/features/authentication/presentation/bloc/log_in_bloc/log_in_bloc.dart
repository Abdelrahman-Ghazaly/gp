import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/log_in.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<PostDataEvent, LogInState> {
  final LogIn logIn;

  LogInBloc({required this.logIn}) : super(Empty()) {
    on<PostDataEvent>(
      (event, emit) async {
        emit(Loading());
        final Either<Failure, UserEntity> failureOrUser = await logIn(
          Params(email: event.email, password: event.password),
        );
        emit(
          await _eitherFailureOrUser(failureOrUser),
        );
      },
    );
  }
}

Future<LogInState> _eitherFailureOrUser(
    Either<Failure, UserEntity> failureOrUser) async {
  return failureOrUser.fold(
    (failure) => Error(message: failure.message),
    (userEntity) => Success(userEntity: userEntity),
  );
}
