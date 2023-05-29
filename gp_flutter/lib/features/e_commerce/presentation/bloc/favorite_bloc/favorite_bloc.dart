import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/error/failure.dart';
import 'package:gp_flutter/features/authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart';
import 'package:gp_flutter/features/e_commerce/domain/entities/furniture_entity.dart';
import 'package:gp_flutter/features/e_commerce/domain/use_cases/favorite/add_favorite_to_remote_data_source.dart'
    as add_favorite;
import 'package:gp_flutter/features/e_commerce/domain/use_cases/favorite/delete_faorite_fron_remote_data_source.dart'
    as delete_favorite;
import 'package:gp_flutter/features/e_commerce/domain/use_cases/favorite/get_favorite_fron_remote_data_source.dart'
    as get_favorite;

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final add_favorite.AddFavoriteToRenoteDataSource addFavorite;
  final delete_favorite.DeleteFavoriteFromRenoteDataSource deleteFavorite;
  final get_favorite.GetFavoriteFromRenoteDataSource getFavorite;

  FavoriteBloc({
    required this.addFavorite,
    required this.deleteFavorite,
    required this.getFavorite,
  }) : super(Empty()) {
    on<AddFavoriteEvent>((event, emit) async {
      emit(Loading());
      final failureOrAdded = await addFavorite(
        add_favorite.Params(
          accessToken: event.accessToken,
          productId: event.productId,
        ),
      );
      emit(await _eitherFailureOrAdded(failureOrAdded));
    });
    on<DeleteFavoriteEvent>((event, emit) async {
      emit(Loading());
      final failureOrDeleted = await deleteFavorite(
        delete_favorite.Params(
          accessToken: event.accessToken,
          productId: event.productId,
        ),
      );
      emit(await _eitherFailureOrDeleted(failureOrDeleted));
    });
    on<GetFavoriteEvent>((event, emit) async {
      emit(Loading());
      final failureOrFurnitureList = await getFavorite(
        get_favorite.Params(
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
      (furnitureEntities) =>
          LoadedFavorite(furnitureEntities: furnitureEntities),
    );
  }
}
