import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/furniture_entity.dart';
import '../../../domain/use_cases/get_furniture/get_furniture_from_id.dart';

part 'product_view_event.dart';
part 'product_view_state.dart';

class ProductViewBloc extends Bloc<ProductViewEvent, ProductViewState> {
  final GetFurnitureFromId getFurnitureFromId;
  ProductViewBloc({required this.getFurnitureFromId}) : super(Empty()) {
    on<GetFurnitureFromIdEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrfurniture =
            await getFurnitureFromId(Params(id: event.id));
        emit(await _eitherLoadedOrErrorState(failureOrfurniture));
      },
    );
  }
  Future<ProductViewState> _eitherLoadedOrErrorState(
    Either<Failure, FurnitureEntity> failureOrFurniture,
  ) async {
    return failureOrFurniture.fold(
      (failure) => Error(message: failure.message),
      (furnitureEntity) => Loaded(furnitureEntity: furnitureEntity),
    );
  }
}
