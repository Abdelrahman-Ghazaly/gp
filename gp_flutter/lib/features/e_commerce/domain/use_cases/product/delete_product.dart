import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../repositories/e_commerce_repository.dart';

class DeleteFurniture implements BaseUseCase<String, Params> {
  final ECommerceRepository repository;

  DeleteFurniture({required this.repository});

  @override
  Future<Either<Failure, String>> call(Params params) {
    return repository.deleteFurniture(
      productId: params.productId,
      accessToken: params.accessToken,
      isAuction: params.isAuction,
    );
  }
}

class Params extends Equatable {
  final String productId;
  final String accessToken;
  final bool isAuction;

  const Params(
      {required this.productId,
      required this.accessToken,
      required this.isAuction});

  @override
  List<Object?> get props => [productId, accessToken, isAuction];
}
