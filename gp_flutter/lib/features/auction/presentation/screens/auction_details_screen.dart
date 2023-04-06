import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_flutter/core/utils/utilities.dart';

import '../../../../core/app_constants/app_colors.dart';

class AuctionDetailsScreen extends StatelessWidget {
  const AuctionDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = Utilities.screenWidth;
    final height = Utilities.screenHeight;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: width,
                    height: height * 0.5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment(0.8, 1),
                        colors: auctionDetailsLinearGradient,
                        tileMode: TileMode.mirror,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.05,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.black26,
                              radius: width * 0.03,
                              child: GestureDetector(
                                onTap: () {
                                  return context.go('/');
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: width * 0.05,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.7,
                              child: const Text(
                                textAlign: TextAlign.center,
                                "Live Auction",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.15,
                            ),
                          ],
                        ),
                        Container(
                          width: width * 0.8,
                          height: height * 0.35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                  image: AssetImage("assets/images/bed.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.35,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),
                            const Text(
                              "Afro Weed",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width * 0.3,
                                  height: height * 0.1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text("Creator",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.person_pin,
                                            size: height * 0.04,
                                          ),
                                          const Text(
                                            "Osama ",
                                            style: TextStyle(
                                              fontSize: 23,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.3,
                                  height: height * 0.1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Text("Ending in",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey)),
                                      Text(
                                        "28 : 32 : 12",
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const Text("Description",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            const Text(
                                "Color : white Style: Modern Suitable for : Indoor use Room : BedroomColor : white Style: Modern Suitable for : Indoor use Room : BedroomColor : white Style: Modern Suitable for : Indoor use Room : BedroomColor : white Style: Modern Suitable for : Indoor use Room : BedroomColor : white Style: Modern Suitable for : Indoor use Room : BedroomColor : white Style: Modern Suitable for : Indoor use Room : BedroomColor : white Style: Modern Suitable for : Indoor use Room : Bedroom",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              /*     Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: height * 0.05),
                  child:  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child:
                    ),
                ),
              )*/
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            height: height * 0.1,
            width: width * 0.9,
            decoration: const BoxDecoration(
              color: Color(0xff2f314f),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: height * 0.07,
                  width: width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text("Highest Bid",
                          style: TextStyle(fontSize: 22, color: Colors.white)),
                      Text("8.52 USD",
                          style: TextStyle(fontSize: 22, color: Colors.white))
                    ],
                  ),
                ),
                Container(
                  height: height * 0.07,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                    color: const Color(0xfff9f08d),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Text("Place a bid",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
