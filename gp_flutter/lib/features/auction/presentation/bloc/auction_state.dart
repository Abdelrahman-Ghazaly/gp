part of 'auction_bloc.dart';

abstract class AuctionState extends Equatable {
  const AuctionState();

  @override
  List<Object> get props => [];
}

class Loading extends AuctionState {}

class Empty extends AuctionState {}

class Loaded extends AuctionState {
  final List<AuctionEntities> auctionList;

  const Loaded({
    required this.auctionList,
  });

  @override
  List<Object> get props => [auctionList];
}
class Error extends AuctionState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
