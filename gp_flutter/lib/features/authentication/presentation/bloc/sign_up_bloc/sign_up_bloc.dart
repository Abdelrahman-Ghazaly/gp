import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/usecases/sign_up.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUp signUp;

  SignUpBloc({required this.signUp}) : super(Empty()) {
    on<PostDataEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrSuccess = await signUp(
          Params(userModel: event.userModel),
        );
        emit(await _eitherFailureOrSuccess(failureOrSuccess));
      },
    );
  }
  Future<SignUpState> _eitherFailureOrSuccess(
      Either<Failure, void> failureOrSuccess) async {
    return failureOrSuccess.fold(
      (failure) => Error(message: failure.message),
      (_) => Success(),
    );
  }
}
