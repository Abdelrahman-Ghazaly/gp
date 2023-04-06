import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/furniture_entity.dart';
import '../entities/search_query_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetFurnitureFromSearchByCategoryAndPrice
    implements BaseUseCase<List<FurnitureEntity>, Params> {
  final ECommerceRepository repository;

  GetFurnitureFromSearchByCategoryAndPrice({required this.repository});

  @override
  Future<Either<Failure, List<FurnitureEntity>>> call(Params params) {
    return repository.getFurnitureFromSearchByCategoryAndPrice(
        categoryQueryEntity: params.categoryQueryEntity);
  }
}

class Params extends Equatable {
  final CategoryQueryEntity categoryQueryEntity;

  const Params({required this.categoryQueryEntity});

  @override
  List<Object?> get props => [categoryQueryEntity];
}