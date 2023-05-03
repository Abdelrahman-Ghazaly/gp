import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserCredentialsEntity extends Equatable {
  final String accessToken;
  final String userId;

  const UserCredentialsEntity({
    required this.accessToken,
    required this.userId,
  });

  @override
  List<Object?> get props => [
        accessToken,
        userId,
      ];
}
