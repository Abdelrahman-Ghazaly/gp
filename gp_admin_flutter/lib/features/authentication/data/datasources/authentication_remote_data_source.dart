import 'package:dio/dio.dart';

import '../../../../core/app_constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/error_message_model.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<UserEntity> logIn({
    required String email,
    required String password,
  });
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  final Dio dio;

  AuthenticationRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<UserEntity> logIn(
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
      UserEntity userEntity = UserModel.fromMap(response.data);

      return userEntity;
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
