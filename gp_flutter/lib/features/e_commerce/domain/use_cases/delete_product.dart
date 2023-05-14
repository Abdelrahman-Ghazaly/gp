import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../authentication/domain/entities/user_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/e_commerce_repository.dart';

class DeleteFurniture implements BaseUseCase<String, Params> {
  final ECommerceRepository repository;

  DeleteFurniture({required this.repository});

  @override
  Future<Either<Failure, String>> call(Params params) {
    return repository.deleteFurniture(
      productId: params.productId,
      userEntity: params.userEntity,
    );
  }
}

class Params extends Equatable {
  final int productId;
  final UserEntity userEntity;

  const Params({
    required this.productId,
    required this.userEntity,
  });

  @override
  List<Object?> get props => [productId, userEntity];
}
