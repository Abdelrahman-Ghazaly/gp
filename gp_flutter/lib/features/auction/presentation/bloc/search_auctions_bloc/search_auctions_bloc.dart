import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/features/auction/domain/usecases/get_auction_products_search_result_usecase.dart'
    as search_usecase;

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/auction_entities.dart';
import '../../../domain/entities/search_query_entity.dart';

part 'search_auctions_event.dart';
part 'search_auctions_state.dart';

class SearchAuctionsBloc
    extends Bloc<SearchAuctionsEvent, SearchAuctionsState> {
  final search_usecase.GetAuctionProductsSearchResultUseCase
      getAuctionProductsSearchResultUseCase;

  SearchAuctionsBloc(this.getAuctionProductsSearchResultUseCase)
      : super(Loading()) {
    on<GetAuctionProductSearchEvent>((event, emit) async {
      emit(Loading());
      final failureOrAuctionList = await getAuctionProductsSearchResultUseCase(
          search_usecase.Params(searchQueryEntity: event.searchQueryEntity));

      emit(await _eitherLoadedOrErrorState(failureOrAuctionList));
    });
  }
}

Future<SearchAuctionsState> _eitherLoadedOrErrorState(
  Either<Failure, List<AuctionEntities>> failureOrAuctionList,
) async {
  return failureOrAuctionList.fold(
    (failure) => Error(message: failure.message),
    (auctionList) {
      return Loaded(auctionList: auctionList);
    },
  );
}
