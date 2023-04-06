import 'package:flutter/material.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/utils/utilities.dart';

class ShowMoreButton extends StatelessWidget {
  const ShowMoreButton({Key? key, required this.onTap}) : super(key: key);
final  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final width = Utilities.screenWidth;
    final height = Utilities.screenHeight;
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.065,
        width: width * 0.7,
        decoration: BoxDecoration(
            gradient:  const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: auctionLinearGradient,
              tileMode: TileMode.mirror,
            ),
            borderRadius: BorderRadius.circular(100),
            color: Colors.white),
        child: const Center(
          child: Text("Show More",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
