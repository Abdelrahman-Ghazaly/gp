part of 'user_product_bloc.dart';

abstract class UserProductState extends Equatable {
  const UserProductState();

  @override
  List<Object> get props => [];
}

class UserProductDartInitial extends UserProductState {}

class Empty extends UserProductState {}

class Loading extends UserProductState {}

class Loaded extends UserProductState {
  final List<FurnitureEntity> furnitureEntities;

  const Loaded({required this.furnitureEntities});

  @override
  List<Object> get props => [furnitureEntities];
}

class Error extends UserProductState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
