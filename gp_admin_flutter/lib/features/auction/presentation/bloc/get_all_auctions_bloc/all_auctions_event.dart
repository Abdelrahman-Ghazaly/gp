part of 'all_auctions_bloc.dart';

abstract class AllAuctionsEvent extends Equatable {
  const AllAuctionsEvent();

  @override
  List<Object> get props => [];
}

class GetAuctionProductsEvent extends AllAuctionsEvent {
  final String adminToken;

  const GetAuctionProductsEvent({required this.adminToken});
}

class UpdateAuctionList extends AllAuctionsEvent {
  final List<AuctionEntities> auctionList;

  const UpdateAuctionList({required this.auctionList});
}
