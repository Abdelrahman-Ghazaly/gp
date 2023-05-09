import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../../domain/entities/furniture_entity.dart';
import '../../../domain/use_cases/get_popular_furniture_by_category.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPopularFurniturebyCategory getPopularFurniturebyCategory;
  HomeBloc({required this.getPopularFurniturebyCategory}) : super(Empty()) {
    on<GetPopularFurniturebyCategoryEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrfurnitureList =
            await getPopularFurniturebyCategory(NoParams());
        emit(await _eitherLoadedOrErrorStateForMap(failureOrfurnitureList));
      },
    );
  }
  Future<HomeState> _eitherLoadedOrErrorStateForMap(
    Either<Failure, Map<String, List<FurnitureEntity>>> failureOrFurnitureMap,
  ) async {
    return failureOrFurnitureMap.fold(
      (failure) => Error(message: failure.message),
      (furnitureMap) => Loaded(furnitureMap: furnitureMap),
    );
  }
}
