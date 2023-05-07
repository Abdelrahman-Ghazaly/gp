part of 'e_commerce_bloc.dart';

abstract class ECommerceState extends Equatable {
  const ECommerceState();

  @override
  List<Object?> get props => [];
}

class Empty extends ECommerceState {}

class Loading extends ECommerceState {}

class Loaded extends ECommerceState {
  final List<FurnitureEntity>? furnitureList;
  final FurnitureEntity? furnitureEntity;
  final Map<String, List<FurnitureEntity>>? furnitureMap;

  const Loaded({
    this.furnitureList,
    this.furnitureEntity,
    this.furnitureMap,
  });

  @override
  List<Object?> get props => [
        furnitureList,
        furnitureEntity,
        furnitureMap,
      ];

  Loaded copyWith({
    List<FurnitureEntity>? furnitureList,
    FurnitureEntity? furnitureEntity,
    Map<String, List<FurnitureEntity>>? furnitureMap,
  }) {
    return Loaded(
      furnitureList: furnitureList ?? this.furnitureList,
      furnitureEntity: furnitureEntity ?? this.furnitureEntity,
      furnitureMap: furnitureMap ?? this.furnitureMap,
    );
  }
}

class Success extends ECommerceState {
  final String message;

  const Success({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class Error extends ECommerceState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
