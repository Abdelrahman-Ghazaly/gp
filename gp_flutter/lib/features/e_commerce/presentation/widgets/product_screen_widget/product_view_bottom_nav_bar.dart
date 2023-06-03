import 'package:flutter/material.dart';
import 'package:gp_flutter/core/app_constants/app_colors.dart';

import '../../../../../core/utils/utilities.dart';
import 'product_screen_widgets.dart';

class ProductViewBottomNavBar extends StatelessWidget {
  const ProductViewBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Utilities.screenWidth,
      height: Utilities.screenHeight * 0.07,
      decoration: const BoxDecoration(
        color: AppColors.appGreemColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 9,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomNavBarButton(
            text: 'SMS',
            icon: Icons.email_outlined,
          ),
          BottomNavBarButton(
            text: 'Chat',
            icon: Icons.chat_outlined,
          ),
          BottomNavBarButton(
            text: 'Call',
            icon: Icons.phone_outlined,
            isCall: true,
          ),
        ],
      ),
    );
  }
}
