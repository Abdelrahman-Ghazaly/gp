import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/bid_auction_usecase.dart';

import '../../../../../../core/error/failure.dart';

part 'bid_auction_event.dart';
part 'bid_auction_state.dart';

class BidAuctionBloc extends Bloc<BaseBidAuctionEvent, BidAuctionState> {
  final BidAuctionUseCase bidAuctionUseCase;
  BidAuctionBloc(this.bidAuctionUseCase) : super(BidAuctionBlocInitial()) {
    on<BidAuctionEvent>((event, emit) async {
      emit(Loading());
      final failureOrAuctionList = await bidAuctionUseCase(Params(
          bidAmount: event.bidAmount,
          userToken: event.userToken,
          auctionId: event.auctionId));

      emit(await _eitherLoadedOrErrorState(failureOrAuctionList));
    });
  }
}

Future<BidAuctionState> _eitherLoadedOrErrorState(
  Either<Failure, String> failureOrAuctionList,
) async {
  return failureOrAuctionList.fold(
    (failure) => Error(message: failure.message),
    (message) {
      return Loaded(message: message);
    },
  );
}
