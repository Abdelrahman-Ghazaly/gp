import 'package:flutter/material.dart';

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
        color: Color(0xff2f314f),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 9,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
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
