import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/features/authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart';

import '../../../../../core/app_constants/app_constants.dart';
import '../../../../../core/utils/utilities.dart';
import '../../../../chat/data/datasources/chat_remote_data_source.dart';
import '../../../domain/entities/furniture_entity.dart';
import 'report_button.dart';

class ProductDetailsForm extends StatelessWidget {
  const ProductDetailsForm({
    Key? key,
    required this.furnitureEntity,
  }) : super(key: key);
  final FurnitureEntity furnitureEntity;

  @override
  Widget build(BuildContext context) {
    final logInState = context.read<LogInBloc>().state;
    if (logInState is Success) {
      ChatRemoteDataSourceImpl(dio: Dio()).getConversations(
        userId: logInState.userEntity.id!,
        accessToken: logInState.userEntity.accessToken!,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Utilities.screenWidth * 0.6,
              child: Text(
                furnitureEntity.title,
                style: AppTextStyles.appBarTextStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              'EGP ${furnitureEntity.price}',
              style: AppTextStyles.headerTextStyle.copyWith(
                color: AppColors.appGreemColor,
                fontSize: 25,
              ),
            ),
          ],
        ),
        kSpacing(15),
        Text(
          'Seller',
          style: AppTextStyles.headerTextStyle.copyWith(
            color: Colors.grey,
          ),
        ),
        Text(
          furnitureEntity.sellerEntity!.name,
          style: AppTextStyles.appBarTextStyle,
        ),
        kSpacing(10),
        Text(
          'Description',
          style: AppTextStyles.headerTextStyle.copyWith(
            color: Colors.grey,
          ),
        ),
        kSpacing(5),
        Text(
          furnitureEntity.description,
          style: AppTextStyles.titileTextStyle,
        ),
        kSpacing(Utilities.screenHeight * 0.10),
        const ReportButton()
      ],
    );
  }
}
