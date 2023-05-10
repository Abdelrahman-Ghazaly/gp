import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/furniture_entity.dart';
import '../entities/query_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetFurnitureFromSearch
    implements BaseUseCase<List<FurnitureEntity>, Params> {
  final ECommerceRepository repository;

  GetFurnitureFromSearch({required this.repository});

  @override
  Future<Either<Failure, List<FurnitureEntity>>> call(Params params) async {
    return await repository.getFurnitureFromSearch(
      queryEntity: params.queryEntity,
    );
  }
}

class Params extends Equatable {
  final QueryEntity queryEntity;

  const Params({required this.queryEntity});

  @override
  List<Object?> get props => [queryEntity];
}
