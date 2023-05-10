import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/app_constants/app_values.dart';
import '../../../../../core/utils/utilities.dart';
import '../../widgets/form_text_field.dart';
import 'password_screen.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    late String email;
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LottieBuilder.asset(
                  AppAnimations.lottieFemaleProfileAnimation,
                  height: Utilities.screenHeight * 0.25,
                ),
                Text(
                  'Enter Your Email',
                  style: AppTextStyles.appBarTextStyle,
                ),
                kSpacing(15),
                Form(
                  key: formKey,
                  child: FormTextField(
                    icon: Icons.email_outlined,
                    labelText: 'Email',
                    controller: controller,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return _validateEmail(value);
                    },
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  email = controller.text;
                  Utilities().pushTo(
                    context,
                    screen: PasswordScreen(
                      email: email,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(Utilities.screenWidth, 50),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

String? _validateEmail(String value) {
  if (!value.isValidEmail()) {
    return 'Please enter a valid email';
  }
  return null;
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
