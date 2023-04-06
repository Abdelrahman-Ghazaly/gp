
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/furniture_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetFurnitureFromSearchByMinPrice
    implements BaseUseCase<List<FurnitureEntity>, Params> {
  final ECommerceRepository repository;

  GetFurnitureFromSearchByMinPrice({required this.repository});

  @override
  Future<Either<Failure, List<FurnitureEntity>>> call(Params params) async {
    return repository.getFurnitureFromSearchByMinPrice(
        minPrice: params.minPrice);
  }
}

class Params extends Equatable {
  final int minPrice;

  const Params({required this.minPrice});

  @override
  List<Object?> get props => [minPrice];
}
