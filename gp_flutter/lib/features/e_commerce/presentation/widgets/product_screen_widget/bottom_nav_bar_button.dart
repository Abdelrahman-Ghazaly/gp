import 'package:flutter/material.dart';

import '../../../../../core/app_constants/app_values.dart';

class BottomNavBarButton extends StatelessWidget {
  const BottomNavBarButton({
    super.key,
    required this.text,
    required this.icon,
    this.isCall = false,
  });
  final String text;
  final IconData icon;
  final bool isCall;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: isCall ? Colors.white : null,
          border: Border.all(
            width: 1,
            color: isCall ? Colors.black : Colors.white,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 15,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isCall ? Colors.black : Colors.white,
              ),
              kSpacing(5),
              Text(
                text,
                style: TextStyle(
                  color: isCall ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
