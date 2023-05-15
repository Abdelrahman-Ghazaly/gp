import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/auction_entities.dart';
import '../../../domain/usecases/view_auction_data.dart';

part 'get_auction_by_id_event.dart';
part 'get_auction_by_id_state.dart';

class GetAuctionByIdBloc
    extends Bloc<GetAuctionByIdEvent, GetAuctionByIdState> {
  final ViewAuctionDataUseCase viewAuctionDataUseCase;

  GetAuctionByIdBloc(this.viewAuctionDataUseCase) : super(Loading()) {
    on<GetDataEvent>((event, emit) async {
      emit(Loading());
      final failureOrAuctionData =
          await viewAuctionDataUseCase(event.auctionId);

      emit(await _eitherLoadedOrErrorState(failureOrAuctionData));
    });
  }
}

Future<GetAuctionByIdState> _eitherLoadedOrErrorState(
  Either<Failure, AuctionEntities> failureOrAuctionData,
) async {
  return failureOrAuctionData.fold(
    (failure) => Error(message: failure.message),
    (auctionData) {
      return Loaded(auctionData: auctionData);
    },
  );
}
