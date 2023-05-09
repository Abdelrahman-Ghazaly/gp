part of 'upload_product_bloc.dart';

abstract class UploadProductState extends Equatable {
  const UploadProductState();

  @override
  List<Object> get props => [];
}

class Empty extends UploadProductState {}

class Loading extends UploadProductState {}

class Success extends UploadProductState {
  final String message;

  const Success({required this.message});

  @override
  List<Object> get props => [message];
}

class Error extends UploadProductState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
