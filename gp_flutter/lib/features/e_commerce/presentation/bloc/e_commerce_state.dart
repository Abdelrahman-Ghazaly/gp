part of 'e_commerce_bloc.dart';

abstract class ECommerceState extends Equatable {
  const ECommerceState();

  @override
  List<Object> get props => [];
}

class Empty extends ECommerceState {}

class Loading extends ECommerceState {}

class Loaded extends ECommerceState {
  final List<FurnitureEntity> furnitureList;

  const Loaded({
    required this.furnitureList,
  });

  @override
  List<Object> get props => [furnitureList];
}

class Error extends ECommerceState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
