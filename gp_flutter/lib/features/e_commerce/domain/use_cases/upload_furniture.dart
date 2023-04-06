
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/furniture_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/e_commerce_repository.dart';

class UploadFurniture implements BaseUseCase<String, Params> {
  final ECommerceRepository repository;

  UploadFurniture({required this.repository});

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await repository.uploadFurniture(
      furniture: params.furniture,
    );
  }
}

class Params extends Equatable {
  final FurnitureModel furniture;

  const Params({required this.furniture});

  @override
  List<Object?> get props => [furniture];
}
