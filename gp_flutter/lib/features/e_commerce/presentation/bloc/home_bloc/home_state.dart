part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class Empty extends HomeState {}

class Loading extends HomeState {}

class Loaded extends HomeState {
  final Map<String, List<FurnitureEntity>> furnitureMap;

  const Loaded({required this.furnitureMap});

  @override
  List<Object> get props => [furnitureMap];
}

class Error extends HomeState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
