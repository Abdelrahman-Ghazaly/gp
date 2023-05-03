import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/features/authentication/data/models/user_model.dart';
import 'package:gp_flutter/features/authentication/presentation/bloc/authentication_bloc.dart';

class Scree extends StatelessWidget {
  const Scree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthenticationBloc>().add(
          const LogInEvent(
            email: 'email@email.com',
            password: 'password',
          ),
        );
    return Container();
  }
}
