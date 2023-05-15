part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class PostDataEvent extends SignUpEvent {
  final UserModel userModel;

  const PostDataEvent({required this.userModel});

  @override
  List<Object> get props => [userModel];
}
