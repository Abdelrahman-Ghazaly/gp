import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/furniture_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetFurnitureFromSearchByPriceRange
    implements BaseUseCase<List<FurnitureEntity>, Params> {
  final ECommerceRepository repository;

  GetFurnitureFromSearchByPriceRange({required this.repository});

  @override
  Future<Either<Failure, List<FurnitureEntity>>> call(Params params) {
    return repository.getFurnitureFromSearchByPriceRange(
      maxPrice: params.maxPrice,
      minPrice: params.minPrice,
    );
  }
}

class Params extends Equatable {
  final int maxPrice;
  final int minPrice;

  const Params({
    required this.maxPrice,
    required this.minPrice,
  });

  @override
  List<Object?> get props => [maxPrice, maxPrice];
}