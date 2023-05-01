import 'package:flutter/material.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/utils/utilities.dart';

class AuctionSearchScreen extends StatelessWidget {
  const AuctionSearchScreen({super.key, required this.auctionSearch});
  final String auctionSearch;
  @override
  Widget build(BuildContext context) {
    final width = Utilities.screenWidth;
    final height = Utilities.screenHeight;
    TextEditingController searchController = TextEditingController();
    searchController.text = auctionSearch;
    return Scaffold(
      body: Center(
        child: Container(
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
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: "Search",
                  child: Material(
                    type: MaterialType.transparency,
                    child: SizedBox(
                      height: height * 0.06,
                      width: width * 0.65,
                      child: TextField(
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.normal,
                            color: AppColors.appBlackColor),
                        decoration: InputDecoration(
                          labelText: "Search",
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            color: AppColors.appBlackColor.withOpacity(0.7),
                            fontSize: 22,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_alt_outlined)),
            ],
          ),
        ),
      ),
    );
  }
}
