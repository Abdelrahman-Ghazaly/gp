
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/furniture_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetFurnitureFromSearchByQuery
    implements BaseUseCase<List<FurnitureEntity>, Params> {
  final ECommerceRepository repository;

  GetFurnitureFromSearchByQuery({required this.repository});

  @override
  Future<Either<Failure, List<FurnitureEntity>>> call(Params params) async {
    return await repository.getFurnitureFromSearchByQuery(
      searchQuery: params.searchQuery,
    );
  }
}

class Params extends Equatable {
  final String searchQuery;

  const Params({required this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}
