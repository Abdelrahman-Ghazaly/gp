import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';
import 'package:gp_flutter/features/e_commerce/domain/repositories/e_commerce_repository.dart';

class AddFavoriteFronLocalDataSource implements BaseUseCase<void, Params> {
  final ECommerceRepository repository;

  AddFavoriteFronLocalDataSource({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(Params params) {
    return repository.addFavoriteFromLocalDataSource(
        favoritesIds: params.favoritesIds);
  }
}

class Params extends Equatable {
  final List<String> favoritesIds;

  const Params({required this.favoritesIds});

  @override
  List<Object?> get props => [favoritesIds];
}
