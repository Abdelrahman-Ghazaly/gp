import 'package:flutter/material.dart';

import '../../../../../core/app_constants/app_values.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppTextStyles.appBarTextStyle,
      ),
    );
  }
}
