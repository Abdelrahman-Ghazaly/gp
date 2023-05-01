part of 'all_auctions_bloc.dart';

abstract class AllAuctionsState extends Equatable {
  const AllAuctionsState();

  @override
  List<Object> get props => [];
}

class Loading extends AllAuctionsState {}

class Empty extends AllAuctionsState {}

class Loaded extends AllAuctionsState {
  final List<AuctionEntities> auctionList;

  const Loaded({
    required this.auctionList,
  });

  @override
  List<Object> get props => [auctionList];
}
class Error extends AllAuctionsState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
