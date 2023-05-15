part of 'upload_product_bloc.dart';

abstract class UploadProductEvent extends Equatable {
  const UploadProductEvent();

  @override
  List<Object> get props => [];
}

class UploadFurnitureEvent extends UploadProductEvent {
  final FurnitureModel furniture;
  final UserEntity userEntity;

  const UploadFurnitureEvent({
    required this.furniture,
    required this.userEntity,
  });

  @override
  List<Object> get props => [furniture, userEntity];
}
