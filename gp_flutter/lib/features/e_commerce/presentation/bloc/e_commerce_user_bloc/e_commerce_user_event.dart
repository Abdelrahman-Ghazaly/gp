part of 'e_commerce_user_bloc.dart';

abstract class ECommerceUserEvent extends Equatable {
  const ECommerceUserEvent();

  @override
  List<Object> get props => [];
}

class GetFurnitureFromUserIdEvent extends ECommerceUserEvent {
  final String accessToken;
  final String userId;

  const GetFurnitureFromUserIdEvent({
    required this.accessToken,
    required this.userId,
  });

  @override
  List<Object> get props => [accessToken, userId];
}
