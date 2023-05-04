import 'package:gp_flutter/core/error/exceptions.dart';
import 'package:gp_flutter/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:gp_flutter/features/authentication/data/models/user_model.dart';
import 'package:gp_flutter/features/authentication/domain/entities/user_entity.dart';

import 'package:gp_flutter/core/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/authentication_repository.dart';

class AuthenitcationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;

  AuthenitcationRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> logIn(
      {required String email, required String password}) async {
    try {
      UserEntity userEntity =
          await remoteDataSource.logIn(email: email, password: password);
      return Right(userEntity);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, void>> signUp({required UserModel user}) async {
    try {
      return Right(
        await remoteDataSource.signUp(user: user),
      );
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
