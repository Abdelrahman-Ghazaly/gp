import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_auction_by_id_event.dart';
part 'get_auction_by_id_state.dart';

class GetAuctionByIdBloc extends Bloc<GetAuctionByIdEvent, GetAuctionByIdState> {
  GetAuctionByIdBloc() : super(GetAuctionByIdInitial()) {
    on<GetAuctionByIdEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
