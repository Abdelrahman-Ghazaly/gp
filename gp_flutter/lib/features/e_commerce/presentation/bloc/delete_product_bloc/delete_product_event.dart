part of 'delete_product_bloc.dart';

abstract class DeleteProductEvent extends Equatable {
  const DeleteProductEvent();

  @override
  List<Object> get props => [];
}

class DeleteFurnitureEvent extends DeleteProductEvent {
  final String productId;
  final String accessToken;
  final bool isAuction;

  const DeleteFurnitureEvent(
      {required this.productId,
      required this.accessToken,
      required this.isAuction});

  @override
  List<Object> get props => [productId, accessToken, isAuction];
}
