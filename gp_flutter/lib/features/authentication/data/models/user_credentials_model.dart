import 'package:gp_flutter/features/authentication/domain/entities/user_credentials_entity.dart';

class UserCredentialsModel extends UserCredentialsEntity {
  const UserCredentialsModel({
    required super.accessToken,
    required super.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'userId': userId,
    };
  }

  factory UserCredentialsModel.fromMap(Map<String, dynamic> map) {
    return UserCredentialsModel(
      accessToken: map['accessToken'] ?? '',
      userId: map['userId'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        accessToken,
        userId,
      ];
}
