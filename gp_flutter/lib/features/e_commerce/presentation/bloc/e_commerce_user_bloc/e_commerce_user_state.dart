part of 'e_commerce_user_bloc.dart';

abstract class ECommerceUserState extends Equatable {
  const ECommerceUserState();

  @override
  List<Object> get props => [];
}

class Empty extends ECommerceUserState {}

class Loading extends ECommerceUserState {}

class Loaded extends ECommerceUserState {
  final UserEntity userEntity;
  final List<FurnitureEntity> productList;
  final List<AuctionEntities> auctionList;

  const Loaded(
      {required this.auctionList,
      required this.productList,
      required this.userEntity});

  @override
  List<Object> get props => [productList, userEntity];
}

class Error extends ECommerceUserState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
