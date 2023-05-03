import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gp_flutter/core/app_constants/api_constants.dart';
import 'package:gp_flutter/features/authentication/data/models/user_credentials_model.dart';
import 'package:gp_flutter/features/authentication/data/models/user_model.dart';
import 'package:gp_flutter/features/authentication/domain/entities/user_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/error_message_model.dart';
import '../../domain/entities/user_credentials_entity.dart';

abstract class AuthenticationRemoteDataSource {
  Future<UserCredentialsEntity> logIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required UserModel user,
  });
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  final Dio dio;

  AuthenticationRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<UserCredentialsEntity> logIn(
      {required String email, required String password}) async {
    Map<String, String> data = {
      'email': email,
      'password': password,
    };
    Response response = await dio.post(
      ApiConstants.logInPath,
      data: data,
    );

    if (response.statusCode == 200) {
      UserCredentialsEntity userCredentialsEntity =
          UserCredentialsModel.fromMap(response.data);
      UserEntity userEntity = UserModel.fromMap(response.data);

      return userCredentialsEntity;
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<void> signUp({required UserModel user}) async {
    Response response = await dio.post(
      ApiConstants.signUpPath,
      data: user.toMap(),
    );
    if (response.statusCode == 201) {
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
