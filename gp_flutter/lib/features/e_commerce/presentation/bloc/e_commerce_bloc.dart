import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/furniture_model.dart';
import '../../domain/entities/furniture_entity.dart';
import '../../domain/entities/query_entity.dart';
import '../../domain/use_cases/delete_product.dart' as delete;

import '../../domain/use_cases/get_popular_furniture_by_category.dart'
    as popular;
import '../../domain/use_cases/upload_furniture.dart' as upload;
import '../../domain/use_cases/get_furniture_from_id.dart' as id;
import '../../domain/use_cases/get_furniture_from_search.dart' as search;

part 'e_commerce_event.dart';
part 'e_commerce_state.dart';

class ECommerceBloc extends Bloc<ECommerceEvent, ECommerceState> {
  final popular.GetPopularFurniturebyCategory getPopularFurniturebyCategory;
  final delete.DeleteFurniture deleteFurniture;
  final upload.UploadFurniture uploadFurniture;
  final id.GetFurnitureFromId getFurnitureFromId;
  final search.GetFurnitureFromSearch getFurnitureFromSearch;

  ECommerceBloc({
    required this.getPopularFurniturebyCategory,
    required this.deleteFurniture,
    required this.uploadFurniture,
    required this.getFurnitureFromId,
    required this.getFurnitureFromSearch,
  }) : super(Empty()) {
    on<GetPopularFurniturebyCategoryEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrfurnitureList =
            await getPopularFurniturebyCategory(NoParams());
        emit(await _eitherLoadedOrErrorStateForMap(failureOrfurnitureList));
      },
    );
    on<GetFurnitureFromIdEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrfurniture =
            await getFurnitureFromId(id.Params(id: event.id));
        emit(await _eitherLoadedOrErrorStateForEntity(failureOrfurniture));
      },
    );
    on<GetFurnitireFromSearchEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrFurnitureList = await getFurnitureFromSearch(
          search.Params(
            queryEntity: event.queryEntity,
          ),
        );
        emit(await _eitherLoadedOrErrorState(failureOrFurnitureList));
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

  _eitherLoadedOrErrorStateForEntity(
      Either<Failure, FurnitureEntity> failureOrfurniture) async {
    return failureOrfurniture.fold(
      (failure) => Error(message: failure.message),
      (furniture) => Loaded().copyWith(furnitureEntity: furniture),
    );
  }
}
