import 'package:equatable/equatable.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:gp_flutter/features/e_commerce/domain/entities/furniture_entity.dart';
import 'package:gp_flutter/features/e_commerce/domain/repositories/e_commerce_repository.dart';

class GetFurniture {
  final ECommerceRepository repository;

  GetFurniture({required this.repository});

  @override
  Future<Either<Failure, FurnitureEntity>> call(Params params) async {
    return await repository.getFurniture(params.furnitureId);
  }
}

class Params extends Equatable {
  final int furnitureId;

  const Params({required this.furnitureId});

  @override
  List<Object?> get props => [furnitureId];
}
