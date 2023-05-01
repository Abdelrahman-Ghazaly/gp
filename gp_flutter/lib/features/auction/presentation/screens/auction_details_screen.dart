import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_flutter/features/auction/presentation/bloc/get_auction_by_id/get_auction_by_id_bloc.dart';
import '../../../../core/utils/utilities.dart';

import '../../../../core/app_constants/app_colors.dart';

class AuctionDetailsScreen extends StatelessWidget {
  final String auctionId;

  const AuctionDetailsScreen({Key? key, required this.auctionId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = Utilities.screenWidth;
    final height = Utilities.screenHeight;
    context.read<GetAuctionByIdBloc>().add(GetDataEvent(auctionId));
    return BlocBuilder<GetAuctionByIdBloc, GetAuctionByIdState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Loaded) {
          return Scaffold(
              body: Column(
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
                          width: width ,
                          height: height * 0.37,
                          child: Swiper(
                            autoplay: true,
                            itemBuilder: (context, index) {
                              return Container(
                                width: width * 0.8,
                                height: height * 0.35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            state.auctionData.image[index]),
                                        fit: BoxFit.fill)),
                              );
                            },
                            itemCount: state.auctionData.image.length,
                            viewportFraction: 0.8,
                            scale: 0.8,
                          ),
                        )
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
                            Text(
                              state.auctionData.title,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
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
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.person_pin,
                                            size: height * 0.04,
                                          ),
                                          Flexible(
                                            child: Text(
                                              state.auctionData.owner.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 23,
                                              ),
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
                                    children: [
                                      const Text("Ending in",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey)),
                                      CountdownTimer(
                                        endTime: DateTime.parse(
                                                state.auctionData.duration)
                                            .millisecondsSinceEpoch,
                                        textStyle:
                                            const TextStyle(fontSize: 15),
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
                            Text(state.auctionData.description,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                        children: [
                          const Text("Highest Bid",
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white)),
                          Text("${state.auctionData.currentPrice} USD",
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.white))
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
          ));
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }
}
