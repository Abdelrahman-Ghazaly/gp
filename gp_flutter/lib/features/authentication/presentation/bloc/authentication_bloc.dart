import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/log_in.dart' as log_in;
import '../../domain/usecases/sign_up.dart' as sign_up;

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final log_in.LogIn logIn;
  final sign_up.SignUp signUp;
  AuthenticationBloc({
    required this.logIn,
    required this.signUp,
  }) : super(Empty()) {
    on<LogInEvent>(
      (event, emit) async {
        emit(Loading());
        final Either<Failure, UserEntity> failureOrUser = await logIn(
          log_in.Params(email: event.email, password: event.password),
        );
        emit(
          await _eitherFailureOrUser(failureOrUser),
        );
      },
    );
    on<SignUpEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrSuccess = await signUp(
          sign_up.Params(userModel: event.userModel),
        );
        emit(await _eitherFailureOrSuccess(failureOrSuccess));
      },
    );
  }

  Future<AuthenticationState> _eitherFailureOrUser(
      Either<Failure, UserEntity> failureOrUser) async {
    return failureOrUser.fold(
      (failure) => Error(message: failure.message),
      (userEntity) => LoggedIn(userEntity: userEntity),
    );
  }

  Future<AuthenticationState> _eitherFailureOrSuccess(
      Either<Failure, void> failureOrSuccess) async {
    return failureOrSuccess.fold(
      (failure) => Error(message: failure.message),
      (_) => SignedUp(),
    );
  }
}
