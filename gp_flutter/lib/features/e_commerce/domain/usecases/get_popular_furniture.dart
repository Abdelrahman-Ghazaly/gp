import 'package:gp_flutter/core/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/use_case/use_case.dart';
import '../entities/furniture_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetPopularFurniture
    implements BaseUseCase<List<FurnitureEntity>, NoParams> {
  final ECommerceRepository repository;

  GetPopularFurniture({required this.repository});

  @override
  Future<Either<Failure, List<FurnitureEntity>>> call(NoParams noParams) async {
    return await repository.getPopularFurniture();
  }
}
