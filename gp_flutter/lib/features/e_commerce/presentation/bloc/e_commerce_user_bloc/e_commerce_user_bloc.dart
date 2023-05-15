import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../../authentication/domain/entities/user_entity.dart';
import '../../../domain/entities/furniture_entity.dart';
import '../../../domain/use_cases/get_user_data.dart';

part 'e_commerce_user_event.dart';
part 'e_commerce_user_state.dart';

class ECommerceUserBloc extends Bloc<ECommerceUserEvent, ECommerceUserState> {
  final GetUserData getUserData;

  ECommerceUserBloc({
    required this.getUserData,
  }) : super(Empty()) {
    on<GetFurnitureFromUserIdEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrfurniture = await getUserData(Params(
          accessToken: event.accessToken,
          userId: event.userId,
        ));
        emit(await _eitherLoadedOrErrorState(failureOrfurniture));
      },
    );
  }
  Future<ECommerceUserState> _eitherLoadedOrErrorState(
    Either<
            Failure,
            ({
              UserEntity userEntity,
              List<FurnitureEntity> productsList,
            })>
        failureOrFurniture,
  ) async {
    return failureOrFurniture.fold(
      (failure) => Error(message: failure.message),
      (result) => Loaded(
        productList: result.productsList,
        userEntity: result.userEntity,
      ),
    );
  }
}
