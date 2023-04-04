import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/furniture_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetFurnitureByCategory
    implements BaseUseCase<List<FurnitureEntity>, Params> {
  final ECommerceRepository repository;

  GetFurnitureByCategory({required this.repository});

  @override
  Future<Either<Failure, List<FurnitureEntity>>> call(Params params) async {
    return await repository.getFurnitureByCategory(
      categoryId: params.categoryId,
    );
  }
}

class Params extends Equatable {
  final int categoryId;

  const Params({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}
