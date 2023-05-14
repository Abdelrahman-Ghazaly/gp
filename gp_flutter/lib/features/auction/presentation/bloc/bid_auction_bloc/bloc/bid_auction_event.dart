part of 'bid_auction_bloc_bloc.dart';

abstract class BaseBidAuctionEvent extends Equatable {
  const BaseBidAuctionEvent();

  @override
  List<Object> get props => [];
}

class BidAuctionEvent extends BaseBidAuctionEvent {
  final int bidAmount;

  const BidAuctionEvent({required this.bidAmount});
}
