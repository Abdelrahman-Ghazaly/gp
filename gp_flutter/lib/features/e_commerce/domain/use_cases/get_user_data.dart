import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../authentication/domain/entities/user_entity.dart';
import '../entities/furniture_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetUserData
    implements
        BaseUseCase<
            ({
              UserEntity userEntity,
              List<FurnitureEntity> productsList,
            }),
            Params> {
  final ECommerceRepository repository;

  GetUserData({required this.repository});

  @override
  Future<
      Either<
          Failure,
          ({
            UserEntity userEntity,
            List<FurnitureEntity> productsList,
          })>> call(Params params) async {
    return await repository.getUserData(
      accessToken: params.accessToken,
      userId: params.userId,
    );
  }
}

class Params extends Equatable {
  final String accessToken;
  final String userId;

  const Params({
    required this.accessToken,
    required this.userId,
  });

  @override
  List<Object?> get props => [
        accessToken,
        userId,
      ];
}
