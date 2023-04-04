import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/e_commerce_repository.dart';

class GetFurnitureByCategory implements BaseUseCase {
  final ECommerceRepository repository;

  GetFurnitureByCategory({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
