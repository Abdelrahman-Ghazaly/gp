import 'package:equatable/equatable.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';
import 'package:gp_flutter/features/authentication/domain/repositories/authentication_repository.dart';

import '../entities/user_entity.dart';

class LogIn implements BaseUseCase<UserEntity, Params> {
  final AuthenticationRepository repository;

  LogIn({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(Params params) {
    return repository.logIn(email: params.email, password: params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
