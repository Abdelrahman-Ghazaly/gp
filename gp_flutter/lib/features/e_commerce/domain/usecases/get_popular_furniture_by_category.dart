import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/furniture_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetPopularFurniturebyCategory
    implements BaseUseCase<List<FurnitureEntity>, NoParams> {
  final ECommerceRepository repository;

  GetPopularFurniturebyCategory({required this.repository});

  @override
  Future<Either<Failure, List<FurnitureEntity>>> call(NoParams noParams) async {
    return await repository.getPopularFurnitureByCategory();
  }
}
