import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/log_in_bloc/log_in_bloc.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LogInBloc>().add(const PostDataEvent(
        email: "Admin@gmail.com", password: "Admin@pass_admin"));
    return Scaffold(
      body: BlocBuilder<LogInBloc, LogInState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Success) {
            return const Center(
              child: Text("Sucess"),
            );
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }
}
