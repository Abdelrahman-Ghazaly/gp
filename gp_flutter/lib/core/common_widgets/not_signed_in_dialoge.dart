import 'package:flutter/material.dart';
import 'package:gp_flutter/core/utils/utilities.dart';
import 'package:gp_flutter/features/authentication/presentation/screens/authentication_screen.dart';

import '../app_constants/app_values.dart';

class NotSignedInDialoge extends StatelessWidget {
  const NotSignedInDialoge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: Utilities.screenHeight * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0.5, 0.5),
            )
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Please continue with an account to have the best experience',
                style: AppTextStyles.headerTextStyle,
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  Utilities().pushAndReplace(
                    context: context,
                    screen: Scaffold(
                      appBar: AppBar(),
                      body: const AuthenticationScreen(),
                    ),
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
                  'Join Us',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
