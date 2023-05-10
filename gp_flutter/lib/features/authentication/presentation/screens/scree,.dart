import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/features/authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart';

import '../../../../core/utils/utilities.dart';
import 'sig_up_screen/email_screen.dart';

class Scree extends StatelessWidget {
  const Scree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LogInBloc>().add(
          const PostDataEvent(
            email: 'email@email.com',
            password: 'password',
          ),
        );
    return ElevatedButton(
      onPressed: () {
        Utilities().pushTo(
          context,
          screen: const EmailScreen(),
        );
      },
      child: const Text('Email Screen'),
    );
  }
}
