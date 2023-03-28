import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'e_commerce_event.dart';
part 'e_commerce_state.dart';

class ECommerceBloc extends Bloc<ECommerceEvent, ECommerceState> {
  ECommerceBloc() : super(ECommerceInitial()) {
    on<ECommerceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
