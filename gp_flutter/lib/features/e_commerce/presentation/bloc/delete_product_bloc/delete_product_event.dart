part of 'delete_product_bloc.dart';

abstract class DeleteProductEvent extends Equatable {
  const DeleteProductEvent();

  @override
  List<Object> get props => [];
}

class DeleteFurnitureEvent extends DeleteProductEvent {
  final String productId;
  final String accessToken;

  const DeleteFurnitureEvent({
    required this.productId,
    required this.accessToken,
  });

  @override
  List<Object> get props => [productId, accessToken];
}
