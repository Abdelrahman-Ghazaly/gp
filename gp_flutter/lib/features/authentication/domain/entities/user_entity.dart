import 'package:equatable/equatable.dart';

import 'user_credentials_entity.dart';

class UserEntity extends Equatable {
  final UserCredentialsEntity? userCredentialsEntity;
  final String name;
  final String email;
  final String? password;
  final String address;
  final String phoneNumber;

  const UserEntity({
    this.userCredentialsEntity,
    required this.name,
    required this.email,
    this.password,
    required this.address,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        userCredentialsEntity,
        name,
        email,
        password,
        address,
        phoneNumber,
      ];
}
