import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bid_auction_event.dart';
part 'bid_auction_state.dart';

class BidAuctionBloc extends Bloc<BaseBidAuctionEvent, BidAuctionState> {
  BidAuctionBloc() : super(BidAuctionBlocInitial()) {
    on<BaseBidAuctionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
