import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/furniture_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetFurniture implements BaseUseCase<FurnitureEntity, Params> {
  final ECommerceRepository repository;

  GetFurniture({required this.repository});

  @override
  Future<Either<Failure, FurnitureEntity>> call(Params params) async {
    return await repository.getFurniture(
      furnitureId: params.furnitureId,
    );
  }
}

class Params extends Equatable {
  final int furnitureId;

  const Params({required this.furnitureId});

  @override
  List<Object?> get props => [furnitureId];
}
