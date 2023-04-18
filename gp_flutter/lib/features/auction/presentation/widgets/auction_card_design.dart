import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/utilities.dart';
import 'show_more_button.dart';

class AuctionCardDesign extends StatelessWidget {
  const AuctionCardDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = Utilities.screenWidth;
    final height = Utilities.screenHeight;
    return Swiper(
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: const DecorationImage(
                  image: AssetImage("assets/images/bed.jpg"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.all(height * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text("Bed",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(height * 0.005),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text("Bed gamed",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.all(height * 0.005),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text("Bed gamed ywas3 ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    ShowMoreButton(
                      onTap: () {
                        return context.go('/auction_details_screen');
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      itemCount: 10,
      viewportFraction: 0.8,
      scale: 0.8,
    );
  }
}
