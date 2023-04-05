import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/e_commerce_repository.dart';

class DeleteProduct implements BaseUseCase<String, Params> {
  final ECommerceRepository repository;

  DeleteProduct({required this.repository});

  @override
  Future<Either<Failure, String>> call(Params params) {
    return repository.deleteProduct(productId: params.productId);
  }
}

class Params extends Equatable {
  final int productId;

  const Params({required this.productId});

  @override
  List<Object?> get props => [productId];
}
