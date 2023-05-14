part of 'request_auction_bloc.dart';

abstract class RequestAuctionEvent extends Equatable {
  const RequestAuctionEvent();

  @override
  List<Object> get props => [];
}

class AcceptAuctionEvent extends RequestAuctionEvent {
  final String adminToken;
  final String auctionId;

  const AcceptAuctionEvent({required this.adminToken, required this.auctionId});
}

class RefuseAuctionEvent extends RequestAuctionEvent {
  final String adminToken;
  final String auctionId;

  const RefuseAuctionEvent({required this.adminToken, required this.auctionId});
}
