part of 'search_furniture_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class Empty extends SearchState {}

class Loading extends SearchState {}

class Loaded extends SearchState {
  final List<FurnitureEntity> furnitureList;

  const Loaded({required this.furnitureList});

  @override
  List<Object> get props => [furnitureList];
}

class Error extends SearchState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
