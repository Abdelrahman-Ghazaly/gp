import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/common_widgets/common_widgets.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/utils/utilities.dart';
import '../bloc/get_all_auctions_bloc/all_auctions_bloc.dart';
import 'show_more_button.dart';

class AuctionCardDesign extends StatelessWidget {
  const AuctionCardDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = Utilities.screenWidth;
    final height = Utilities.screenHeight;
    context.read<AllAuctionsBloc>().add(GetAuctionProductsEvent());
    return BlocBuilder<AllAuctionsBloc, AllAuctionsState>(
      builder: (context, state) {
        if (state is Loading) {
          return const LoadingWidget();
        } else if (state is Loaded) {
          return Swiper(
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: AppColors.appGreyColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                        image: NetworkImage(state.auctionList[index].image[0]),
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
                        child: Center(
                          child: Text(state.auctionList[index].category,
                              style: const TextStyle(
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
                            child: Text(
                                "Current Bid: ${state.auctionList[index].currentPrice} \$",
                                style: const TextStyle(
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
                            child: Text(state.auctionList[index].title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          ShowMoreButton(
                            onTap: () {
                              return context.go(
                                  '/auction_details_screen?auction_id=${state.auctionList[index].auctionId}');
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: state.auctionList.length,
            viewportFraction: 0.8,
            scale: 0.8,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
