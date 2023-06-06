part of 'get_user_name_bloc.dart';

class GetUserNameEvent extends Equatable {
  final String userId;

  const GetUserNameEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}
