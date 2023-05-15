part of 'bid_auction_bloc_bloc.dart';

abstract class BidAuctionState extends Equatable {
  const BidAuctionState();

  @override
  List<Object> get props => [];
}

class BidAuctionBlocInitial extends BidAuctionState {}

class Loading extends BidAuctionState {}

class Loaded extends BidAuctionState {
  final String message;

  const Loaded({required this.message});

  @override
  List<Object> get props => [message];
}

class Error extends BidAuctionState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
