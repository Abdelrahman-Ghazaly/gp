import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/use_case/use_case.dart';
import 'package:gp_flutter/features/auction/domain/usecases/get_auction_products_usecase.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/auction_entities.dart';

part 'auction_event.dart';

part 'auction_state.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
  final GetAuctionProductsUseCase getAuctionProductsUseCase;

  AuctionBloc(this.getAuctionProductsUseCase) : super(Loading()) {
    on<GetAuctionProductsEvent>((event, emit) async {
      emit(Loading());
      final failureOrAuctionList = await getAuctionProductsUseCase(NoParams());

      emit(await _eitherLoadedOrErrorState(failureOrAuctionList));
    });
  }
}

Future<AuctionState> _eitherLoadedOrErrorState(
  Either<Failure, List<AuctionEntities>> failureOrAuctionList,
) async {
  return failureOrAuctionList.fold(
    (failure) => Error(message: failure.message),
    (auctionList) {
      print(auctionList[0].description);
      return Loaded(auctionList: auctionList);},
  );
}
