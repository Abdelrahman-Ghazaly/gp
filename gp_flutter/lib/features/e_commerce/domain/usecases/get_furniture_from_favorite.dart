import 'package:equatable/equatable.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';

import '../entities/furniture_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetFurnitureFromFavorite
    implements BaseUseCase<List<FurnitureEntity>, Params> {
  final ECommerceRepository repository;

  GetFurnitureFromFavorite({required this.repository});

  @override
  Future<Either<Failure, List<FurnitureEntity>>> call(Params params) async {
    return await repository.getFurnitureFromFavorite(
      userId: params.userId,
    );
  }
}

class Params extends Equatable {
  final int userId;

  const Params({required this.userId});

  @override
  List<Object?> get props => [userId];
}
