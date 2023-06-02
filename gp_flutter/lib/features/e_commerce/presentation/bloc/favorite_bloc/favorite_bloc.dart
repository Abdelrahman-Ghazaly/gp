import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/features/e_commerce/domain/entities/furniture_entity.dart';
import 'package:gp_flutter/features/e_commerce/domain/use_cases/favorite/add_favorite.dart'
    as add;
import 'package:gp_flutter/features/e_commerce/domain/use_cases/favorite/delete_favorite.dart'
    as delete;
import 'package:gp_flutter/features/e_commerce/domain/use_cases/favorite/get_favorite.dart'
    as get_fav;

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final add.AddFavorite addFavorite;
  final delete.DeleteFavorite deleteFavorite;
  final get_fav.GetFavorite getFavorite;

  FavoriteBloc({
    required this.addFavorite,
    required this.deleteFavorite,
    required this.getFavorite,
  }) : super(Empty()) {
    on<AddFavoriteEvent>((event, emit) async {
      emit(Loading());
      final failureOrAdded = await addFavorite(
        add.Params(
          accessToken: event.accessToken,
          productId: event.productId,
        ),
      );
      emit(await _eitherFailureOrAdded(failureOrAdded));
    });
    on<DeleteFavoriteEvent>((event, emit) async {
      emit(Loading());
      final failureOrDeleted = await deleteFavorite(
        delete.Params(
          accessToken: event.accessToken,
          productId: event.productId,
        ),
      );
      emit(await _eitherFailureOrDeleted(failureOrDeleted));
    });
    on<GetFavoriteEvent>((event, emit) async {
      emit(Loading());
      final failureOrFurnitureList = await getFavorite(
        get_fav.Params(
          accessToken: event.accessToken,
        ),
      );
      emit(await _eitherFailureOrFurnitureList(failureOrFurnitureList));
    });
  }
  Future<FavoriteState> _eitherFailureOrAdded(
      Either<Failure, String> failureOrAdded) async {
    return failureOrAdded.fold(
      (failure) => Error(message: failure.message),
      (message) => AddedSuccessfully(message: message),
    );
  }

  Future<FavoriteState> _eitherFailureOrDeleted(
      Either<Failure, String> failureOrDeleted) async {
    return failureOrDeleted.fold(
      (failure) => Error(message: failure.message),
      (message) => DeletedSuccessfully(message: message),
    );
  }

  Future<FavoriteState> _eitherFailureOrFurnitureList(failureOrSuccess) async {
    return failureOrSuccess.fold(
      (failure) => Error(message: failure.message),
      (furnitureEntities) => LoadedFavorite(
        furnitureEntities: furnitureEntities,
      ),
    );
  }
}
