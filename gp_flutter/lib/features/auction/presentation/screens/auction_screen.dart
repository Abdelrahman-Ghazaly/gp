import 'package:flutter/material.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/utils/utilities.dart';
import '../widgets/auction_card_design.dart';

class AuctionScreen extends StatelessWidget {
  const AuctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = Utilities.screenWidth;
    final height = Utilities.screenHeight;
    return Scaffold(
        body: Column(children: [
      Container(
        height: height * 0.4,
        width: width,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            const Text("Discover",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const Text("Best Auction Market",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            Container(
              height: height * 0.07,
              width: width * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: auctionLinearGradient,
                  tileMode: TileMode.mirror,
                ),
              ),
            ),
            Center(
                child: Container(
              height: 2,
              width: width * 0.8,
              color: Colors.grey.withOpacity(0.3),
            )),
            SizedBox(
              height: height * 0.04,
            )
          ],
        ),
      ),
      SizedBox(
          height: height * 0.5, width: width, child: const AuctionCardDesign()),
    ]));
  }
}

/*,*/
