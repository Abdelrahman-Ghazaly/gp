import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/app_constants/app_constants.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/furniture_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetFurnitureFromSearchByCategory
    implements BaseUseCase<List<FurnitureEntity>, Params> {
  final ECommerceRepository repository;

  GetFurnitureFromSearchByCategory({required this.repository});

  @override
  Future<Either<Failure, List<FurnitureEntity>>> call(Params params) {
    return repository.getFurnitureFromSearchByCategory(
      category: params.category,
    );
  }
}

class Params extends Equatable {
  final Category category;

  const Params({required this.category});

  @override
  List<Object?> get props => [category];
}
