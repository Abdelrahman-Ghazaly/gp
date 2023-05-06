import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/user_model.dart';
import '../entities/user_entity.dart';

import '../repositories/authentication_repository.dart';

class SignUp extends BaseUseCase<void, Params> {
  final AuthenticationRepository repository;

  SignUp({required this.repository});
  @override
  Future<Either<Failure, void>> call(Params params) {
    return repository.signUp(user: params.userModel);
  }
}

class Params extends Equatable {
  final UserModel userModel;

  const Params({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}
