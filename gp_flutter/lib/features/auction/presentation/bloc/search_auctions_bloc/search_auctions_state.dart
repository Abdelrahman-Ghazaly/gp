part of 'search_auctions_bloc.dart';

abstract class SearchAuctionsState extends Equatable {
  const SearchAuctionsState();

  @override
  List<Object> get props => [];
}

class Loading extends SearchAuctionsState {}

class Empty extends SearchAuctionsState {}

class Loaded extends SearchAuctionsState {
  final List<AuctionEntities> auctionList;

  const Loaded({
    required this.auctionList,
  });

  @override
  List<Object> get props => [auctionList];
}

class Error extends SearchAuctionsState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
