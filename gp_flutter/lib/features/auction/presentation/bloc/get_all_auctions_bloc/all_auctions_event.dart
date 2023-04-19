part of 'all_auctions_bloc.dart';

abstract class AllAuctionsEvent extends Equatable {
  const AllAuctionsEvent();

  @override
  List<Object> get props => [];
}

class GetAuctionProductsEvent extends AllAuctionsEvent {}
