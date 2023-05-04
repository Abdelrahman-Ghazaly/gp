part of 'search_auctions_bloc.dart';

abstract class SearchAuctionsEvent extends Equatable {
  const SearchAuctionsEvent();

  @override
  List<Object> get props => [];
}

class GetAuctionProductSearchEvent extends SearchAuctionsEvent {
  final SearchQueryEntity searchQueryEntity;

  const GetAuctionProductSearchEvent({required this.searchQueryEntity});
}
