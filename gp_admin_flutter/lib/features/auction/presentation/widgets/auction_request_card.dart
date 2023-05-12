import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/app_constants/app_values.dart';
import '../../../../core/utils/utilities.dart';

class AuctionRequestCard extends StatelessWidget {
  const AuctionRequestCard({
    super.key,
    required this.price,
    required this.title,
    required this.img,
    required this.description,
  });
  final String price;
  final String title;
  final String img;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: Utilities.screenHeight * 0.4,
        width: Utilities.screenWidth * 0.9,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.appBlackColor.withOpacity(0.35),
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          color: AppColors.appWhiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: Utilities.screenHeight * 0.25,
                width: Utilities.screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    begin: Alignment.center,
                    end: Alignment(0.8, 1),
                    colors: auctionLinearGradient,
                    tileMode: TileMode.mirror,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      img,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "Title: ",
                    style: AppTextStyles.titileTextStyle.copyWith(
                      color: AppColors.appGreemColor,
                    ),
                  ),
                  Text(
                    title,
                    style: AppTextStyles.titileTextStyle
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Description: ",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: AppTextStyles.titileTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appGreemColor,
                    ),
                  ),
                  SizedBox(
                    width: Utilities.screenWidth * 0.6,
                    child: Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: AppTextStyles.titileTextStyle
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Price: ',
                    style: AppTextStyles.titileTextStyle.copyWith(
                      color: AppColors.appGreemColor,
                    ),
                  ),
                  Text("$price EGP", style: AppTextStyles.titileTextStyle),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
