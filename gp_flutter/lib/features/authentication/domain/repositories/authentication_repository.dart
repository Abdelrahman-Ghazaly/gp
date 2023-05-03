import 'package:dartz/dartz.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/features/authentication/data/models/user_model.dart';
import 'package:gp_flutter/features/authentication/domain/entities/user_credentials_entity.dart';
import 'package:gp_flutter/features/authentication/domain/entities/user_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, UserCredentialsEntity>> logIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signUp({
    required UserModel user,
  });
}
