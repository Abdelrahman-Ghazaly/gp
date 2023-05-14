import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/furniture_entity.dart';
import '../../../domain/use_cases/get_furniture_from_user_id.dart';

part 'user_product_event.dart';
part 'user_product_state.dart';

class UserProductBloc extends Bloc<UserProductEvent, UserProductState> {
  final GetFurnitureFromUserId getFurnitureFromUserId;

  UserProductBloc({
    required this.getFurnitureFromUserId,
  }) : super(UserProductDartInitial()) {
    on<GetFurnitureFromUserIdEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrfurniture = await getFurnitureFromUserId(
            Params(accessToken: event.accessToken));
        emit(await _eitherLoadedOrErrorState(failureOrfurniture));
      },
    );
  }
  Future<UserProductState> _eitherLoadedOrErrorState(
    Either<Failure, List<FurnitureEntity>> failureOrFurniture,
  ) async {
    return failureOrFurniture.fold(
      (failure) => Error(message: failure.message),
      (furnitureEntities) => Loaded(furnitureEntities: furnitureEntities),
    );
  }
}
