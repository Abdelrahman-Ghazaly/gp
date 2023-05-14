part of 'user_product_bloc.dart';

abstract class UserProductEvent extends Equatable {
  const UserProductEvent();

  @override
  List<Object> get props => [];
}

class GetFurnitureFromUserIdEvent extends UserProductEvent {
  final String accessToken;

  const GetFurnitureFromUserIdEvent({required this.accessToken});

  @override
  List<Object> get props => [accessToken];
}
