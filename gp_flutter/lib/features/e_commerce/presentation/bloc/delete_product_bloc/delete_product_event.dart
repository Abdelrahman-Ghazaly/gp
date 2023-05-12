part of 'delete_product_bloc.dart';

abstract class DeleteProductEvent extends Equatable {
  const DeleteProductEvent();

  @override
  List<Object> get props => [];
}

class DeleteFurnitureEvent extends DeleteProductEvent {
  final int productId;
  final UserEntity userEntity;

  const DeleteFurnitureEvent({
    required this.productId,
    required this.userEntity,
  });

  @override
  List<Object> get props => [productId, userEntity];
}
