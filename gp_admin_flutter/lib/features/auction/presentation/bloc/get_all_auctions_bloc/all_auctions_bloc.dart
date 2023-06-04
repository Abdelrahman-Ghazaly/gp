import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';

import '../../../domain/entities/auction_entities.dart';
import '../../../domain/usecases/get_auction_products_usecase.dart';

part 'all_auctions_event.dart';
part 'all_auctions_state.dart';

class AllAuctionsBloc extends Bloc<AllAuctionsEvent, AllAuctionsState> {
  final GetAuctionProductsUseCase getAuctionProductsUseCase;

  AllAuctionsBloc({required this.getAuctionProductsUseCase})
      : super(Loading()) {
    on<GetAuctionProductsEvent>((event, emit) async {
      emit(Loading());
      final failureOrAuctionList =
          await getAuctionProductsUseCase(event.adminToken);

      emit(await _eitherLoadedOrErrorState(failureOrAuctionList));
    });
    on<UpdateAuctionList>((event, emit) async {
      emit(Loaded(auctionList: event.auctionList));
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
