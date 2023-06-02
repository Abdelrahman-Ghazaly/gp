import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';
import 'package:gp_flutter/features/e_commerce/domain/entities/furniture_entity.dart';

import '../../repositories/e_commerce_repository.dart';

class GetFavorite implements BaseUseCase<List<FurnitureEntity>, Params> {
  final ECommerceRepository repository;

  GetFavorite({required this.repository});

  @override
  Future<Either<Failure, List<FurnitureEntity>>> call(Params params) {
    return repository.getFavorite(accessToken: params.accessToken);
  }
}

class Params extends Equatable {
  final String accessToken;

  const Params({
    required this.accessToken,
  });
  @override
  List<Object?> get props => [
        accessToken,
      ];
}
