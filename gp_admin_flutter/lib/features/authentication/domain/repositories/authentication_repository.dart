import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

import '../entities/user_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, UserEntity>> logIn({
    required String email,
    required String password,
  });
}
