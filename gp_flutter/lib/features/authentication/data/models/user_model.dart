import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      accessToken: map['accessToken'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['phone'] ?? '',
    );
  }
  const UserModel({
    super.id,
    super.accessToken,
    required super.name,
    required super.email,
    required super.address,
    required super.phoneNumber,
    super.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': password,
      'address': address,
      'phone': phoneNumber,
    };
  }

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
