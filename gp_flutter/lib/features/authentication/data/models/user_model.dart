import 'package:gp_flutter/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.userCredentialsEntity,
    required super.name,
    required super.email,
    super.password,
    required super.address,
    required super.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': password,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }

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
