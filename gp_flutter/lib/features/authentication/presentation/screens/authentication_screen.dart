import 'package:flutter/material.dart' hide AppBar;

import '../../../../core/app_constants/app_constants.dart';
import '../../../../core/utils/utilities.dart';
import 'log_in_screen.dart';
import 'sig_up_screen/email_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Please continue with an account to have the best experience',
            style: AppTextStyles.headerTextStyle,
            textAlign: TextAlign.center,
          ),
          kSpacing(20),
          ElevatedButton(
            onPressed: () {
              Utilities().pushTo(
                context,
                screen: const EmailScreen(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: Size(Utilities.screenWidth * 0.5, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          kSpacing(20),
          Text(
            'Already have an account?',
            style: AppTextStyles.titileTextStyle,
            textAlign: TextAlign.center,
          ),
          kSpacing(20),
          ElevatedButton(
            onPressed: () {
              Utilities().pushTo(
                context,
                screen: const LogInScreen(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: Size(Utilities.screenWidth * 0.5, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
            ),
            child: const Text(
              'Log in',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
