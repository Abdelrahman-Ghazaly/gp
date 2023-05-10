import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.accessToken,
    required super.name,
    required super.email,
    super.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      accessToken: map['accessToken'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        accessToken,
        name,
        email,
        password,
      ];
}
