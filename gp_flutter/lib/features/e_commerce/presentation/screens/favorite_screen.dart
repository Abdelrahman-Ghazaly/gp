import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../authentication/presentation/screens/authentication_screen.dart';
import '../../../../core/common_widgets/app_bar.dart';
import '../../../authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logInState = context.read<LogInBloc>().state;
    final bool isLoggedIn = logInState is Success;

    if (isLoggedIn) {
      return const AuthenticationScreen();
    } else {}
    return const Scaffold(
      appBar: CustomAppBar(),
    );
  }
}
