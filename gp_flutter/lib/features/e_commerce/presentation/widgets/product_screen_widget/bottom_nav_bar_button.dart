import 'package:flutter/material.dart';
import 'package:gp_flutter/core/app_constants/app_constants.dart';

class BottomNavBarButton extends StatelessWidget {
  const BottomNavBarButton({
    super.key,
    required this.text,
    required this.icon,
    this.isCall = false,
    this.onTap,
  });
  final String text;
  final IconData icon;
  final bool isCall;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isCall ? Colors.white : null,
          border: Border.all(
            width: 1,
            color: isCall ? AppColors.appGreemColor : Colors.white,
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
                color: isCall ? Colors.black54 : Colors.white,
              ),
              kSpacing(5),
              Text(
                text,
                style: TextStyle(
                  color: isCall ? Colors.black54 : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
