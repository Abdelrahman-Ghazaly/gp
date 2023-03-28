import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'view_product_event.dart';
part 'view_product_state.dart';

class ViewProductBloc extends Bloc<ViewProductEvent, ViewProductState> {
  ViewProductBloc() : super(ViewProductInitial()) {
    on<ViewProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
