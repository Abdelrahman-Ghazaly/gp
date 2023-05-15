import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';

import '../../../../../core/error/failure.dart';
import '../../repositories/e_commerce_repository.dart';

class AddFavorite implements BaseUseCase<String, Params> {
  final ECommerceRepository repository;

  AddFavorite({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(Params params) {
    return repository.addFavorite(
      productId: params.productId,
      accessToken: params.accessToken,
    );
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
  List<Object?> get props => [productId, accessToken];
}