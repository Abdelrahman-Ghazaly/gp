import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/utils/utilities.dart';
import '../../domain/entities/search_query_entity.dart';
import '../bloc/search_auctions_bloc/search_auctions_bloc.dart';
import '../widgets/auction_card_design.dart';

class AuctionScreen extends StatelessWidget {
  const AuctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = Utilities.screenWidth;
    final double height = Utilities.screenHeight;
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            height: height * 0.2,
            width: width,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Best Auction Market',
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
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            context.read<SearchAuctionsBloc>().add(
                                  GetAuctionProductSearchEvent(
                                    searchQueryEntity: SearchQueryEntity(
                                      name: searchController.text,
                                      category: '',
                                      maxPrice: '',
                                      minPrice: '',
                                    ),
                                  ),
                                );
                            return context.go(
                              '/auction_search_screen?auction_search=${searchController.text}',
                            );
                          },
                          icon: const Icon(Icons.search)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Hero(
                          tag: 'Search',
                          child: Material(
                            type: MaterialType.transparency,
                            child: SizedBox(
                              height: height * 0.06,
                              width: width * 0.65,
                              child: TextField(
                                controller: searchController,
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.appBlackColor),
                                decoration: InputDecoration(
                                  labelText: 'Search',
                                  border: InputBorder.none,
                                  labelStyle: TextStyle(
                                    color: AppColors.appBlackColor
                                        .withOpacity(0.7),
                                    fontSize: 22,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    height: 2,
                    width: width * 0.8,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                )
              ],
            ),
          ),
          SizedBox(
            height: height * 0.5,
            width: width,
            child: const AuctionCardDesign(),
          ),
        ],
      ),
    );
  }
}
