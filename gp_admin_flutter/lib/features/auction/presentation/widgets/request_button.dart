import 'package:flutter/material.dart';

import '../../../../core/app_constants/app_values.dart';
import '../../../../core/utils/utilities.dart';

class RequestButton extends StatelessWidget {
  const RequestButton({
    super.key,
    required this.text,
    required this.color,
    required this.function,
  });
  final String text;
  final Color color;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: Utilities.screenHeight * 0.05,
        width: Utilities.screenWidth * 0.4,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(child: Text(text, style: AppTextStyles.titileTextStyle)),
      ),
    );
  }
}
