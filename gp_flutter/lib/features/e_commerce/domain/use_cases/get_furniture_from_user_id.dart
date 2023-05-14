import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/furniture_entity.dart';
import '../repositories/e_commerce_repository.dart';

class GetFurnitureFromUserId
    implements BaseUseCase<List<FurnitureEntity>, Params> {
  final ECommerceRepository repository;

  GetFurnitureFromUserId({required this.repository});

  @override
  Future<Either<Failure, List<FurnitureEntity>>> call(Params params) async {
    return await repository.getFurnitureFromUserId(
      accessToken: params.accessToken,
    );
  }
}

class Params extends Equatable {
  final String accessToken;

  const Params({required this.accessToken});

  @override
  List<Object?> get props => [accessToken];
}
