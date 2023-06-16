import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gp_admin_flutter/features/auction/presentation/bloc/get_all_auctions_bloc/all_auctions_bloc.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/app_constants/app_values.dart';

import '../../../../core/utils/utilities.dart';
import '../../../reports/presentation/widgets/report_request_card.dart';
import '../bloc/request_austion_bloc/request_auction_bloc.dart';

class AuctionRequestCard extends StatefulWidget {
  const AuctionRequestCard({
    super.key,
    required this.price,
    required this.title,
    required this.img,
    required this.description,
    required this.adminToken,
    required this.productId,
    required this.auctionIndex,
  });
  final String price;
  final String title;
  final String img;
  final String description;
  final String adminToken;
  final String productId;
  final int auctionIndex;

  @override
  State<AuctionRequestCard> createState() => _AuctionRequestCardState();
}

class _AuctionRequestCardState extends State<AuctionRequestCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: Utilities.screenHeight * 0.45,
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
                      widget.img,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "Title: ",
                    style: AppTextStyles.titileTextStyle.copyWith(
                      color: AppColors.appGreenColor,
                    ),
                  ),
                  Text(
                    widget.title,
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
                      color: AppColors.appGreenColor,
                    ),
                  ),
                  SizedBox(
                    width: Utilities.screenWidth * 0.6,
                    child: Text(
                      widget.description,
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
                      color: AppColors.appGreenColor,
                    ),
                  ),
                  Text("${widget.price} EGP",
                      style: AppTextStyles.titileTextStyle),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: Utilities.screenHeight * 0.05,
                      width: Utilities.screenWidth * 0.4,
                      decoration: BoxDecoration(
                          color: AppColors.appGreenColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: RequestButton(
                        text: "Accept",
                        color: AppColors.appGreenColor,
                        function: () {
                          context.read<RequestAuctionBloc>().add(
                              AcceptAuctionEvent(
                                  adminToken: widget.adminToken,
                                  auctionId: widget.productId));
                          Future.delayed(
                            const Duration(milliseconds: 500),
                            () => context.read<AllAuctionsBloc>().add(
                                GetAuctionProductsEvent(
                                    adminToken: widget.adminToken)),
                          );
                        },
                      )),
                  RequestButton(
                    text: "Refuse",
                    color: AppColors.appGreyColor,
                    function: () {
                      context.read<RequestAuctionBloc>().add(RefuseAuctionEvent(
                          adminToken: widget.adminToken,
                          auctionId: widget.productId));
                      Future.delayed(
                        const Duration(milliseconds: 500),
                        () => context.read<AllAuctionsBloc>().add(
                            GetAuctionProductsEvent(
                                adminToken: widget.adminToken)),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
