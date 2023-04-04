import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'e_commerce_event.dart';
part 'e_commerce_state.dart';

class ECommerceBloc extends Bloc<ECommerceEvent, ECommerceState> {
  ECommerceBloc() : super(ECommerceInitial()) {
    on<ECommerceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
