part of 'delete_product_bloc.dart';

abstract class DeleteProductState extends Equatable {
  const DeleteProductState();

  @override
  List<Object> get props => [];
}

class Empty extends DeleteProductState {}

class Loading extends DeleteProductState {}

class Success extends DeleteProductState {
  final String message;

  const Success({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class Error extends DeleteProductState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
