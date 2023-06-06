part of 'upload_auction_bloc.dart';

abstract class UploadAuctionState extends Equatable {
  const UploadAuctionState();

  @override
  List<Object> get props => [];
}

class Empty extends UploadAuctionState {}

class Loading extends UploadAuctionState {}

class Success extends UploadAuctionState {
  final String message;

  const Success({required this.message});

  @override
  List<Object> get props => [message];
}

class Error extends UploadAuctionState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
