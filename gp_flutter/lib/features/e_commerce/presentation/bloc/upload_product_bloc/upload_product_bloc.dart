import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../../authentication/domain/entities/user_entity.dart';
import '../../../data/models/furniture_model.dart';
import '../../../domain/use_cases/product/upload_furniture.dart';

part 'upload_product_event.dart';
part 'upload_product_state.dart';

class UploadProductBloc extends Bloc<UploadProductEvent, UploadProductState> {
  final UploadFurniture uploadFurniture;

  UploadProductBloc({required this.uploadFurniture}) : super(Empty()) {
    on<UploadFurnitureEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrString = await uploadFurniture(
          Params(
            furniture: event.furniture,
            userEntity: event.userEntity,
          ),
        );
        emit(await _eitherSuccessOrErrorState(failureOrString));
      },
    );
  }
  Future<UploadProductState> _eitherSuccessOrErrorState(
    Either<Failure, String> failureOrString,
  ) async {
    return failureOrString.fold(
      (failure) => Error(message: failure.message),
      (message) => Success(message: message),
    );
  }
}
