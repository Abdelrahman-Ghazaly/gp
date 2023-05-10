import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/app_constants/app_constants.dart';
import '../../../../../core/utils/utilities.dart';
import '../../widgets/form_text_field.dart';
import 'personal_info_screen.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    late String password;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                LottieBuilder.asset(
                  AppAnimations.lottiePasswordAnimation,
                  height: Utilities.screenHeight * 0.25,
                ),
                Text(
                  'Enter a Strong Password for $email',
                  style: AppTextStyles.headerTextStyle,
                  textAlign: TextAlign.center,
                ),
                kSpacing(15),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      FormTextField(
                        icon: Icons.lock_outline,
                        labelText: 'Password',
                        controller: passwordController,
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
                      kSpacing(15),
                      FormTextField(
                        icon: Icons.lock_outline,
                        labelText: 'Confirm Password',
                        controller: confirmPasswordController,
                        isPassword: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (value.length < 8) {
                            return 'Password must be 8 characters or more';
                          }
                          if (value != passwordController.text) {
                            return 'The Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              password = passwordController.text;
              Utilities().pushTo(
                context,
                screen: PersonalInfoScreen(
                  email: email,
                  password: password,
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(Utilities.screenWidth, 50),
          ),
          child: const Text('Next'),
        ),
      ),
    );
  }
}
