import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/features/authentication/domain/entities/user_entity.dart';

import '../../../../../core/error/failure.dart';
import '../../../data/models/furniture_model.dart';
import '../../../domain/entities/seller_entity.dart';
import '../../../domain/use_cases/upload_furniture.dart';

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
