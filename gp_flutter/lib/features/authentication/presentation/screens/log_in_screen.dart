import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common_widgets/bottom_nav_bar.dart';
import '../bloc/log_in_bloc/log_in_bloc.dart';
import 'sig_up_screen/email_screen.dart';
import '../widgets/form_text_field.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/app_constants/app_values.dart';
import '../../../../core/common_widgets/loading_widget.dart';
import '../../../../core/utils/utilities.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LottieBuilder.asset(
                AppAnimations.lottieManProfileAnimation,
                height: Utilities.screenHeight * 0.25,
              ),
              Text(
                'Log In',
                style: AppTextStyles.appBarTextStyle,
                textAlign: TextAlign.center,
              ),
              kSpacing(15),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    FormTextField(
                      icon: Icons.email_outlined,
                      labelText: 'Email',
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return validateEmail(value);
                      },
                    ),
                    kSpacing(15),
                    FormTextField(
                      icon: Icons.password_outlined,
                      labelText: 'Password',
                      controller: password,
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (value.length < 8) {
                          return 'Password must be 8 characters or more';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocListener<LogInBloc, LogInState>(
        listener: (context, state) {
          if (state is Success) {
            Utilities().pushAndReplace(
              context: context,
              screen: const BottomNavBar(),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Container(
                    height: Utilities.screenHeight * 0.4,
                    width: Utilities.screenWidth * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 15,
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0.5, 0.5))
                      ],
                    ),
                    child: _buildDialog(context, state: state),
                  ),
                );
              },
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<LogInBloc>().add(
                      PostDataEvent(
                        email: email.text,
                        password: password.text,
                      ),
                    );
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(Utilities.screenWidth, 50),
            ),
            child: const Text('Log in'),
          ),
        ),
      ),
    );
  }
}

Widget _buildDialog(
  BuildContext context, {
  required LogInState state,
}) {
  if (state is Error) {
    return Center(
      child: Text(
        state.message,
        style: AppTextStyles.appBarTextStyle,
      ),
    );
  } else {
    return const Center(
      child: LoadingWidget(),
    );
  }
}
