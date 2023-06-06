import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gp_admin_flutter/features/reports/presentation/bloc/get_all_reports_bloc/all_reports_bloc.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/app_constants/app_values.dart';

import '../../../../core/utils/utilities.dart';
import '../bloc/accept_refuse_report_bloc/request_report_bloc.dart';

class ReportRequestCard extends StatefulWidget {
  const ReportRequestCard({
    super.key,
    required this.reportType,
    required this.description,
    required this.adminToken,
    required this.productId,
  });

  final String reportType;

  final String description;
  final String adminToken;
  final String productId;

  @override
  State<ReportRequestCard> createState() => _ReportRequestCardState();
}

class _ReportRequestCardState extends State<ReportRequestCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: Utilities.screenHeight * 0.20,
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
              Row(
                children: [
                  Text(
                    "Report Type: ",
                    style: AppTextStyles.titileTextStyle.copyWith(
                      color: AppColors.appGreenColor,
                    ),
                  ),
                  Text(
                    widget.reportType,
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
                          context.read<RequestReportsBloc>().add(
                              AcceptReportEvent(
                                  adminToken: widget.adminToken,
                                  auctionId: widget.productId));
                          Future.delayed(
                            const Duration(milliseconds: 500),
                            () => context.read<AllReportsBloc>().add(
                                GetReportsEvent(adminToken: widget.adminToken)),
                          );
                        },
                      )),
                  RequestButton(
                    text: "Refuse",
                    color: AppColors.appGreyColor,
                    function: () {
                      context.read<RequestReportsBloc>().add(RefuseReportEvent(
                          adminToken: widget.adminToken,
                          auctionId: widget.productId));
                      Future.delayed(
                        const Duration(milliseconds: 500),
                        () => context.read<AllReportsBloc>().add(
                            GetReportsEvent(adminToken: widget.adminToken)),
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

class RequestButton extends StatelessWidget {
  const RequestButton({
    super.key,
    required this.text,
    required this.color,
    required this.function,
  });
  final String text;
  final Color color;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: Utilities.screenHeight * 0.05,
        width: Utilities.screenWidth * 0.4,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(child: Text(text, style: AppTextStyles.titileTextStyle)),
      ),
    );
  }
}
