import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/use_case/use_case.dart';

import '../../../../core/app_constants/app_constants.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/furniture_model.dart';
import '../../domain/entities/furniture_entity.dart';
import '../../domain/entities/search_query_entity.dart';
import '../../domain/use_cases/delete_product.dart' as delete;
import '../../domain/use_cases/get_furniture_from_search_by_category.dart'
    as category;
import '../../domain/use_cases/get_furniture_from_search_by_category_and_price.dart'
    as category_price;
import '../../domain/use_cases/get_furniture_from_search_by_max_price.dart'
    as max_price;
import '../../domain/use_cases/get_furniture_from_search_by_min_price.dart'
    as min_price;
import '../../domain/use_cases/get_furniture_from_search_by_price_range.dart'
    as price_range;
import '../../domain/use_cases/get_furniture_from_search_by_query.dart'
    as query;
import '../../domain/use_cases/get_popular_furniture_by_category.dart'
    as popular;
import '../../domain/use_cases/upload_furniture.dart' as upload;

part 'e_commerce_event.dart';
part 'e_commerce_state.dart';

class ECommerceBloc extends Bloc<ECommerceEvent, ECommerceState> {
  final category_price.GetFurnitureFromSearchByCategoryAndPrice
      getFurnitireFromSearchByCategoryAndPrice;
  final price_range.GetFurnitureFromSearchByPriceRange
      getFurnitireFromSearchByPriceRange;
  final category.GetFurnitureFromSearchByCategory
      getFurnitureFromSearchByCategory;
  final max_price.GetFurnitureFromSearchByMaxPrice
      getFurnitureFromSearchByMaxPrice;
  final min_price.GetFurnitureFromSearchByMinPrice
      getFurnitureFromSearchByMinPrice;
  final query.GetFurnitureFromSearchByQuery getFurnitureFromSearchByQuery;
  final popular.GetPopularFurniturebyCategory getPopularFurniturebyCategory;
  final delete.DeleteFurniture deleteFurniture;
  final upload.UploadFurniture uploadFurniture;

  ECommerceBloc({
    required this.getFurnitireFromSearchByCategoryAndPrice,
    required this.getFurnitireFromSearchByPriceRange,
    required this.getFurnitureFromSearchByCategory,
    required this.getFurnitureFromSearchByMaxPrice,
    required this.getFurnitureFromSearchByMinPrice,
    required this.getFurnitureFromSearchByQuery,
    required this.getPopularFurniturebyCategory,
    required this.deleteFurniture,
    required this.uploadFurniture,
  }) : super(Empty()) {
    on<GetFurnitireFromSearchByCategoryAndPriceEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrFurnitureList =
            await getFurnitireFromSearchByCategoryAndPrice(
          category_price.Params(categoryQueryEntity: event.categoryQueryEntity),
        );
        emit(await _eitherLoadedOrErrorState(failureOrFurnitureList));
      },
    );
    on<GetFurnitireFromSearchByPriceRangeEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrFurnitureList = await getFurnitireFromSearchByPriceRange(
          price_range.Params(
            maxPrice: event.maxPrice,
            minPrice: event.minPrice,
          ),
        );
        emit(await _eitherLoadedOrErrorState(failureOrFurnitureList));
      },
    );
    on<GetFurnitureFromSearchByCategoryEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrFurnitureList = await getFurnitureFromSearchByCategory(
          category.Params(
            category: event.category,
          ),
        );
        emit(await _eitherLoadedOrErrorState(failureOrFurnitureList));
      },
    );
    on<GetFurnitureFromSearchByMaxPriceEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrFurnitureList = await getFurnitureFromSearchByMaxPrice(
          max_price.Params(
            maxPrice: event.maxPrice,
          ),
        );
        emit(await _eitherLoadedOrErrorState(failureOrFurnitureList));
      },
    );
    on<GetFurnitureFromSearchByMinPriceEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrFurnitureList = await getFurnitureFromSearchByMinPrice(
          min_price.Params(
            minPrice: event.minPrice,
          ),
        );
        emit(await _eitherLoadedOrErrorState(failureOrFurnitureList));
      },
    );
    on<GetFurnitureFromSearchByQueryEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrFurnitureList = await getFurnitureFromSearchByQuery(
          query.Params(
            searchQuery: event.searchQuery,
          ),
        );
        emit(await _eitherLoadedOrErrorState(failureOrFurnitureList));
      },
    );
    on<GetPopularFurniturebyCategoryEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrfurnitureList =
            await getPopularFurniturebyCategory(NoParams());
        emit(await _eitherLoadedOrErrorStateForMap(failureOrfurnitureList));
      },
    );
    on<DeleteProductEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrString = await deleteFurniture(
          delete.Params(
            productId: event.productId,
          ),
        );
        emit(await _eitherSuccessOrErrorState(failureOrString));
      },
    );
    on<UploadFurnitureEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrString = await uploadFurniture(
          upload.Params(
            furniture: event.furniture,
          ),
        );
        emit(await _eitherSuccessOrErrorState(failureOrString));
      },
    );
  }

  Future<ECommerceState> _eitherLoadedOrErrorState(
    Either<Failure, List<FurnitureEntity>> failureOrFurnitureList,
  ) async {
    return failureOrFurnitureList.fold(
      (failure) => Error(message: failure.message),
      (furnitureList) => Loaded(furnitureList: furnitureList),
    );
  }

  Future<ECommerceState> _eitherLoadedOrErrorStateForMap(
    Either<Failure, Map<String, List<FurnitureEntity>>> failureOrFurnitureMap,
  ) async {
    return failureOrFurnitureMap.fold(
      (failure) => Error(message: failure.message),
      (furnitureMap) => Loaded(furnitureMap: furnitureMap),
    );
  }

  Future<ECommerceState> _eitherSuccessOrErrorState(
    Either<Failure, String> failureOrString,
  ) async {
    return failureOrString.fold(
      (failure) => Error(message: failure.message),
      (message) => Success(message: message),
    );
  }
}
