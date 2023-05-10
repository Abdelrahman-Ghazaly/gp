import 'package:flutter/material.dart' hide AppBar;

import '../../../../core/app_constants/app_constants.dart';
import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/utils/utilities.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Please Continue iwth an account to Have The Best Experience',
            style: AppTextStyles.headerTextStyle,
            textAlign: TextAlign.center,
          ),
          kSpacing(20),
          Text(
            'Already have an account?',
            style: AppTextStyles.titileTextStyle,
            textAlign: TextAlign.center,
          ),
          kSpacing(20),
          ElevatedButton(
            onPressed: () {},
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
