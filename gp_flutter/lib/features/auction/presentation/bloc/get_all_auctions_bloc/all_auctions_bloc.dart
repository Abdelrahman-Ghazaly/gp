import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../../domain/entities/auction_entities.dart';
import '../../../domain/usecases/get_auction_products_usecase.dart';

part 'all_auctions_event.dart';
part 'all_auctions_state.dart';

class AllAuctionsBloc extends Bloc<AllAuctionsEvent, AllAuctionsState> {
  final GetAuctionProductsUseCase getAuctionProductsUseCase;

  AllAuctionsBloc(this.getAuctionProductsUseCase) : super(Loading()) {
    on<GetAuctionProductsEvent>((event, emit) async {
      emit(Loading());
      final failureOrAuctionList = await getAuctionProductsUseCase(NoParams());

      emit(await _eitherLoadedOrErrorState(failureOrAuctionList));
    });
  }
}

Future<AllAuctionsState> _eitherLoadedOrErrorState(
  Either<Failure, List<AuctionEntities>> failureOrAuctionList,
) async {
  return failureOrAuctionList.fold(
    (failure) => Error(message: failure.message),
    (auctionList) {
      return Loaded(auctionList: auctionList);
    },
  );
}
