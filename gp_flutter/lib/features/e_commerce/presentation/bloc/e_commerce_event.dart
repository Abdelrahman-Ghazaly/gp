part of 'e_commerce_bloc.dart';

abstract class ECommerceEvent extends Equatable {
  const ECommerceEvent();

  @override
  List<Object> get props => [];
}

class GetFurnitireFromSearchByCategoryAndPriceEvent extends ECommerceEvent {
  final CategoryQueryEntity categoryQueryEntity;

  const GetFurnitireFromSearchByCategoryAndPriceEvent(
      {required this.categoryQueryEntity});

  @override
  List<Object> get props => [categoryQueryEntity];
}

class GetFurnitireFromSearchByPriceRangeEvent extends ECommerceEvent {
  final int maxPrice;
  final int minPrice;

  const GetFurnitireFromSearchByPriceRangeEvent({
    required this.maxPrice,
    required this.minPrice,
  });

  @override
  List<Object> get props => [
        maxPrice,
        minPrice,
      ];
}

class GetFurnitureFromSearchByCategoryEvent extends ECommerceEvent {
  final Category category;

  const GetFurnitureFromSearchByCategoryEvent({required this.category});

  @override
  List<Object> get props => [category];
}

class GetFurnitureFromSearchByMaxPriceEvent extends ECommerceEvent {
  final int maxPrice;

  const GetFurnitureFromSearchByMaxPriceEvent({required this.maxPrice});

  @override
  List<Object> get props => [maxPrice];
}

class GetFurnitureFromSearchByMinPriceEvent extends ECommerceEvent {
  final int minPrice;

  const GetFurnitureFromSearchByMinPriceEvent({required this.minPrice});

  @override
  List<Object> get props => [minPrice];
}

class GetFurnitureFromSearchByQueryEvent extends ECommerceEvent {
  final String searchQuery;

  const GetFurnitureFromSearchByQueryEvent({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}

class GetPopularFurniturebyCategoryEvent extends ECommerceEvent {}

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
