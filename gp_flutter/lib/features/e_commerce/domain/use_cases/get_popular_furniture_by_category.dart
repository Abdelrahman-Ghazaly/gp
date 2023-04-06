import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/app_constants/app_constants.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/furniture_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetPopularFurniturebyCategory
    implements BaseUseCase<List<FurnitureEntity>, Params> {
  final ECommerceRepository repository;

  GetPopularFurniturebyCategory({required this.repository});

  @override
  Future<Either<Failure, List<FurnitureEntity>>> call(Params params) async {
    return await repository.getPopularFurnitureByCategory(
        category: params.category);
  }
}

class Params extends Equatable {
  final Category category;

  const Params({required this.category});

  @override
  List<Object?> get props => [category];
}
