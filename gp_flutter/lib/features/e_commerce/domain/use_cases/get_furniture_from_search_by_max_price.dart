
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/furniture_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetFurnitureFromSearchByMaxPrice
    implements BaseUseCase<List<FurnitureEntity>, Params> {
  final ECommerceRepository repository;

  GetFurnitureFromSearchByMaxPrice({required this.repository});

  @override
  Future<Either<Failure, List<FurnitureEntity>>> call(Params params) async {
    return repository.getFurnitureFromSearchByMaxPrice(
        maxPrice: params.maxPrice);
  }
}

class Params extends Equatable {
  final int maxPrice;

  const Params({required this.maxPrice});

  @override
  List<Object?> get props => [maxPrice];
}
