import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';

import '../../repositories/e_commerce_repository.dart';

class DeleteFavorite implements BaseUseCase<String, Params> {
  final ECommerceRepository repository;

  DeleteFavorite({required this.repository});

  @override
  Future<Either<Failure, String>> call(Params params) {
    return repository.deleteFavorite(
        productId: params.productId, accessToken: params.accessToken);
  }
}

class Params extends Equatable {
  final String productId;
  final String accessToken;

  const Params({
    required this.productId,
    required this.accessToken,
  });
  @override
  List<Object?> get props => [
        productId,
        accessToken,
      ];
}
