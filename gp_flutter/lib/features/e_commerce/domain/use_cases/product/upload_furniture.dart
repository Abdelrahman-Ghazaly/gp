import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../../../authentication/domain/entities/user_entity.dart';
import '../../../data/models/furniture_model.dart';
import '../../repositories/e_commerce_repository.dart';

class UploadFurniture implements BaseUseCase<String, Params> {
  final ECommerceRepository repository;

  UploadFurniture({required this.repository});

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await repository.uploadFurniture(
      furniture: params.furniture,
      userEntity: params.userEntity,
    );
  }
}

class Params extends Equatable {
  final FurnitureModel furniture;
  final UserEntity userEntity;

  const Params({
    required this.furniture,
    required this.userEntity,
  });

  @override
  List<Object?> get props => [furniture, userEntity];
}
