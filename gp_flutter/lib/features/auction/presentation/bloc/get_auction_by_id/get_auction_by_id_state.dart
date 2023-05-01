part of 'get_auction_by_id_bloc.dart';

abstract class GetAuctionByIdState extends Equatable {
  const GetAuctionByIdState();

  @override
  List<Object> get props => [];
}

class Loading extends GetAuctionByIdState {}

class Loaded extends GetAuctionByIdState {
  final AuctionEntities auctionData;

  const Loaded({
    required this.auctionData,
  });

  @override
  List<Object> get props => [auctionData];
}

class Error extends GetAuctionByIdState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
