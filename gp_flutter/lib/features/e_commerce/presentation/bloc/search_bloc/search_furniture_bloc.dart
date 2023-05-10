import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/furniture_entity.dart';
import '../../../domain/entities/query_entity.dart';
import '../../../domain/use_cases/get_furniture_from_search.dart';

part 'search_furniture_event.dart';
part 'search_furniture_state.dart';

class SearchFurnitureBloc extends Bloc<SearchEvent, SearchState> {
  final GetFurnitureFromSearch getFurnitureFromSearch;
  SearchFurnitureBloc({required this.getFurnitureFromSearch}) : super(Empty()) {
    on<GetFurnitireFromSearchEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrFurnitureList = await getFurnitureFromSearch(
          Params(queryEntity: event.queryEntity),
        );
        emit(await _eitherLoadedOrErrorState(failureOrFurnitureList));
      },
    );
  }
  Future<SearchState> _eitherLoadedOrErrorState(
    Either<Failure, List<FurnitureEntity>> failureOrFurnitureList,
  ) async {
    return failureOrFurnitureList.fold(
      (failure) => Error(message: failure.message),
      (furnitureList) => Loaded(furnitureList: furnitureList),
    );
  }
}
