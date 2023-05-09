import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/furniture_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetFurnitureFromId implements BaseUseCase<FurnitureEntity, Params> {
  final ECommerceRepository repository;

  GetFurnitureFromId({
    required this.repository,
  });

  @override
  Future<Either<Failure, FurnitureEntity>> call(Params params) {
    return repository.getFurnitureFromId(id: params.id);
  }
}

class Params extends Equatable {
  final String id;

  const Params({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
