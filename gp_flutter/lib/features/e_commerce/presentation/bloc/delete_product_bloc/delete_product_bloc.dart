import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/use_cases/delete_product.dart';

part 'delete_product_event.dart';
part 'delete_product_state.dart';

class DeleteProductBloc extends Bloc<DeleteProductEvent, DeleteProductState> {
  final DeleteFurniture deleteFurniture;
  DeleteProductBloc({required this.deleteFurniture}) : super(Empty()) {
    on<DeleteFurnitureEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrString = await deleteFurniture(
          Params(productId: event.productId),
        );
        emit(await _eitherSuccessOrErrorState(failureOrString));
      },
    );
  }
  Future<DeleteProductState> _eitherSuccessOrErrorState(
    Either<Failure, String> failureOrString,
  ) async {
    return failureOrString.fold(
      (failure) => Error(message: failure.message),
      (message) => Success(message: message),
    );
  }
}
