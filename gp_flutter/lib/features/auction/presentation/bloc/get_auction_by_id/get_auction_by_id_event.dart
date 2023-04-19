part of 'get_auction_by_id_bloc.dart';

abstract class GetAuctionByIdEvent extends Equatable {
  const GetAuctionByIdEvent();
}
class GetDataEvent extends GetAuctionByIdEvent{
  final String auctionId ;

  const GetDataEvent(this.auctionId);
  @override
  List<Object?> get props =>[auctionId];
}