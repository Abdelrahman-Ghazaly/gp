part of 'e_commerce_bloc.dart';

abstract class ECommerceEvent extends Equatable {
  const ECommerceEvent();

  @override
  List<Object> get props => [];
}

class DeleteProduct extends ECommerceEvent {
  final int productId;

  const DeleteProduct({required this.productId});

  @override
  List<Object> get props => [productId];
}

class GetFurnitireFromSearchByCategoryAndPrice extends ECommerceEvent {
  final CategoryQueryEntity categoryQueryEntity;

  const GetFurnitireFromSearchByCategoryAndPrice(
      {required this.categoryQueryEntity});

  @override
  List<Object> get props => [categoryQueryEntity];
}

class GetFurnitireFromSearchByPriceRange extends ECommerceEvent {
  final int maxPrice;
  final int minPrice;

  const GetFurnitireFromSearchByPriceRange({
    required this.maxPrice,
    required this.minPrice,
  });

  @override
  List<Object> get props => [
        maxPrice,
        minPrice,
      ];
}

class GetFurnitureFromSearchByCategory extends ECommerceEvent {
  final Category category;

  const GetFurnitureFromSearchByCategory({required this.category});

  @override
  List<Object> get props => [category];
}

class GetFurnitureFromSearchByMaxPrice extends ECommerceEvent {
  final int maxPrice;

  const GetFurnitureFromSearchByMaxPrice({required this.maxPrice});

  @override
  List<Object> get props => [maxPrice];
}

class GetFurnitureFromSearchByMinPrice extends ECommerceEvent {
  final int minPrice;

  const GetFurnitureFromSearchByMinPrice({required this.minPrice});

  @override
  List<Object> get props => [minPrice];
}

class GetFurnitureFromSearchByQuery extends ECommerceEvent {
  final String searchQuery;

  const GetFurnitureFromSearchByQuery({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}

class GetPopularFurniturebyCategory extends ECommerceEvent {}

class UploadFurniture extends ECommerceEvent {
  final FurnitureEntity furniture;

  const UploadFurniture({required this.furniture});

  @override
  List<Object> get props => [furniture];
}
