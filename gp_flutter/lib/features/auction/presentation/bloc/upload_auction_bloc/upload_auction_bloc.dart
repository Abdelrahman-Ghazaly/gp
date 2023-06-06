import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/features/auction/domain/entities/auction_entities.dart';
import 'package:gp_flutter/features/auction/domain/usecases/upload_auction_product_usecase.dart'
    as upload_usecase;

import '../../../../../core/error/failure.dart';

part 'upload_auction_event.dart';
part 'upload_auction_state.dart';

class UploadAuctionBloc extends Bloc<UploadAuctionEvent, UploadAuctionState> {
  final upload_usecase.UploadAuctionProductUseCase uploadAuctionProductUseCase;
  UploadAuctionBloc(this.uploadAuctionProductUseCase) : super(Empty()) {
    on<UploadAuctionEvent>((event, emit) async {
      emit(Loading());
      final failureOrString = await uploadAuctionProductUseCase(
          upload_usecase.Params(
              auctionEntities: event.auctionEntities,
              userToken: event.userToken));

      emit(await _eitherSuccessOrErrorState(failureOrString));
    });
  }
}

Future<UploadAuctionState> _eitherSuccessOrErrorState(
  Either<Failure, String> failureOrString,
) async {
  return failureOrString.fold(
    (failure) => Error(message: failure.message),
    (message) => Success(message: message),
  );
}
