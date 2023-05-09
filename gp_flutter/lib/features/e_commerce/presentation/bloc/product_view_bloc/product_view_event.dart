part of 'product_view_bloc.dart';

abstract class ProductViewEvent extends Equatable {
  const ProductViewEvent();

  @override
  List<Object> get props => [];
}

class GetFurnitureFromIdEvent extends ProductViewEvent {
  final String id;

  const GetFurnitureFromIdEvent({required this.id});

  @override
  List<Object> get props => [id];
}
