part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class Empty extends FavoriteState {}

class Loading extends FavoriteState {}

class LoadedFavorite extends FavoriteState {
  final List<FurnitureEntity> furnitureEntities;

  const LoadedFavorite({required this.furnitureEntities});

  @override
  List<Object> get props => [furnitureEntities];
}

class AddedSuccessfully extends FavoriteState {
  final String message;

  const AddedSuccessfully({required this.message});

  @override
  List<Object> get props => [message];
}

class DeletedSuccessfully extends FavoriteState {
  final String message;

  const DeletedSuccessfully({required this.message});

  @override
  List<Object> get props => [message];
}

class Error extends FavoriteState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
