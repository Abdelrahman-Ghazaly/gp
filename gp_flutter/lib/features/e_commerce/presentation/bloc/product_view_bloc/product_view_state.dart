part of 'product_view_bloc.dart';

abstract class ProductViewState extends Equatable {
  const ProductViewState();

  @override
  List<Object> get props => [];
}

class Empty extends ProductViewState {}

class Loading extends ProductViewState {}

class Loaded extends ProductViewState {
  final FurnitureEntity furnitureEntity;

  const Loaded({required this.furnitureEntity});

  @override
  List<Object> get props => [furnitureEntity];
}

class Error extends ProductViewState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
