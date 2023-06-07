part of 'upload_auction_bloc.dart';

abstract class UploadAuction extends Equatable {
  const UploadAuction();

  @override
  List<Object> get props => [];
}

class UploadAuctionEvent extends UploadAuction {
  final String userToken;
  final AuctionEntities auctionEntities;

  const UploadAuctionEvent(
      {required this.auctionEntities, required this.userToken});

  @override
  List<Object> get props => [auctionEntities, userToken];
}
