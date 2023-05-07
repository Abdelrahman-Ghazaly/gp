part of 'e_commerce_bloc.dart';

abstract class ECommerceEvent extends Equatable {
  const ECommerceEvent();

  @override
  List<Object> get props => [];
}

class GetFurnitureFromIdEvent extends ECommerceEvent {
  final String id;

  const GetFurnitureFromIdEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class GetFurnitireFromSearchEvent extends ECommerceEvent {
  final QueryEntity queryEntity;

  const GetFurnitireFromSearchEvent({required this.queryEntity});

  @override
  List<Object> get props => [queryEntity];
}

class GetPopularFurniturebyCategoryEvent extends ECommerceEvent {
  const GetPopularFurniturebyCategoryEvent();
}

class UploadFurnitureEvent extends ECommerceEvent {
  final FurnitureModel furniture;

  const UploadFurnitureEvent({required this.furniture});

  @override
  List<Object> get props => [furniture];
}

class DeleteProductEvent extends ECommerceEvent {
  final int productId;

  const DeleteProductEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}
