import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_constants/app_constants.dart';
import '../../domain/entities/search_query_entity.dart';
import '../../domain/usecases/get_furniture_from_search_by_max_price.dart';
import '../../domain/usecases/get_furniture_from_search_by_min_price.dart';
import '../../domain/usecases/get_furniture_from_search_by_query.dart';
import '../../domain/usecases/get_popular_furniture_by_category.dart';
import '../../domain/usecases/upload_furniture.dart';
import '../../domain/entities/furniture_entity.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_furnitire_from_search_by_category_and_price.dart';
import '../../domain/usecases/get_furnitire_from_search_by_price_range.dart';
import '../../domain/usecases/get_furniture_from_search_by_category.dart';

part 'e_commerce_event.dart';
part 'e_commerce_state.dart';

class ECommerceBloc extends Bloc<ECommerceEvent, ECommerceState> {
  final DeleteProduct deleteProduct;
  final GetFurnitireFromSearchByCategoryAndPrice
      getFurnitireFromSearchByCategoryAndPrice;
  final GetFurnitireFromSearchByPriceRange getFurnitireFromSearchByPriceRange;
  final GetFurnitureFromSearchByCategory getFurnitureFromSearchByCategory;
  final GetFurnitureFromSearchByMaxPrice getFurnitureFromSearchByMaxPrice;
  final GetFurnitureFromSearchByMinPrice getFurnitureFromSearchByMinPrice;
  final GetFurnitureFromSearchByQuery getFurnitureFromSearchByQuery;
  final GetPopularFurniturebyCategory getPopularFurniturebyCategory;
  final UploadFurniture uploadFurniture;

  ECommerceBloc({
    required this.deleteProduct,
    required this.getFurnitireFromSearchByCategoryAndPrice,
    required this.getFurnitireFromSearchByPriceRange,
    required this.getFurnitureFromSearchByCategory,
    required this.getFurnitureFromSearchByMaxPrice,
    required this.getFurnitureFromSearchByMinPrice,
    required this.getFurnitureFromSearchByQuery,
    required this.getPopularFurniturebyCategory,
    required this.uploadFurniture,
  }) : super(Empty()) {
    on<ECommerceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
