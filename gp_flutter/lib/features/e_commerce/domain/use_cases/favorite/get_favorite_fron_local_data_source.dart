import 'package:dartz/dartz.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';
import 'package:gp_flutter/features/e_commerce/domain/repositories/e_commerce_repository.dart';

class GetFavoriteFronLocalDataSource
    implements BaseUseCase<List<String>, NoParams> {
  final ECommerceRepository repository;

  GetFavoriteFronLocalDataSource({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<String>>> call(NoParams noParams) {
    return repository.getFavoriteFromLocalDataSource();
  }
}
