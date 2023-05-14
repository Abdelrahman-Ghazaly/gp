import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';

import '../../../domain/usecases/accept_auction_usecase.dart' as accept_auction;
import '../../../domain/usecases/refuse_auction_usecase.dart' as refuse_auction;

part 'request_auction_event.dart';
part 'request_auction_state.dart';

class RequestAuctionBloc
    extends Bloc<RequestAuctionEvent, RequestAuctionState> {
  final accept_auction.AcceptAuctionUseCase acceptAuctionUseCase;
  final refuse_auction.RefuseAuctionUseCase refuseAuctionUseCase;
  RequestAuctionBloc({
    required this.acceptAuctionUseCase,
    required this.refuseAuctionUseCase,
  }) : super(Empty()) {
    on<AcceptAuctionEvent>((event, emit) async {
      final failureOrAuctionList = await acceptAuctionUseCase(
          accept_auction.Params(
              adminToken: event.adminToken, productId: event.auctionId));

      emit(await _eitherSuccessOrErrorState(failureOrAuctionList));
    });
    on<RefuseAuctionEvent>((event, emit) async {
      final failureOrAuctionList = await refuseAuctionUseCase(
          refuse_auction.Params(
              adminToken: event.adminToken, productId: event.auctionId));

      emit(await _eitherSuccessOrErrorState(failureOrAuctionList));
    });
  }
  Future<RequestAuctionState> _eitherSuccessOrErrorState(
    Either<Failure, String> failureOrString,
  ) async {
    return failureOrString.fold(
      (failure) => Error(message: failure.message),
      (message) => Success(message: message),
    );
  }
}
