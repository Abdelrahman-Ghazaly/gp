import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String name;
  final String email;
  final String? password;
  final String address;
  final String phoneNumber;
  final String? accessToken;

  const UserEntity({
    this.id,
    this.accessToken,
    required this.name,
    required this.email,
    this.password,
    required this.address,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        id,
        accessToken,
        name,
        email,
        password,
        address,
        phoneNumber,
      ];
}
