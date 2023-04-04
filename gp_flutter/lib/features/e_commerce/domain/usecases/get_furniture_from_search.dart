import 'package:equatable/equatable.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';

import '../entities/furniture_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetFurnitureFromSearch
    implements BaseUseCase<List<FurnitureEntity>, Params> {
  final ECommerceRepository repository;

  GetFurnitureFromSearch({required this.repository});

  @override
  Future<Either<Failure, List<FurnitureEntity>>> call(Params params) async {
    return await repository.getFurnitureFromSearch(
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
