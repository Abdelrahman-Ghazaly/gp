part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class AddFavoriteEvent extends FavoriteEvent {
  final String productId;
  final String accessToken;

  const AddFavoriteEvent({
    required this.productId,
    required this.accessToken,
  });

  @override
  List<Object> get props => [accessToken, productId];
}

class DeleteFavoriteEvent extends FavoriteEvent {
  final String productId;
  final String accessToken;

  const DeleteFavoriteEvent({
    required this.productId,
    required this.accessToken,
  });

  @override
  List<Object> get props => [accessToken, productId];
}

class GetFavoriteEvent extends FavoriteEvent {
  final String accessToken;

  const GetFavoriteEvent({
    required this.accessToken,
  });

  @override
  List<Object> get props => [accessToken];
}
