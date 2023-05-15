part of 'request_auction_bloc.dart';

abstract class RequestAuctionState extends Equatable {
  const RequestAuctionState();

  @override
  List<Object> get props => [];
}

class Empty extends RequestAuctionState {}

class Loading extends RequestAuctionState {}

class Success extends RequestAuctionState {
  final String message;

  const Success({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class Error extends RequestAuctionState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
