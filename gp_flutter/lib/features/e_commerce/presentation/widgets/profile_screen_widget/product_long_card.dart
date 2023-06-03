import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/app_constants/app_constants.dart';
import 'package:gp_flutter/core/utils/utilities.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/delete_product_bloc/delete_product_bloc.dart';

import '../../../../authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart'
    as log_in;
import '../../bloc/e_commerce_user_bloc/e_commerce_user_bloc.dart';

class ProductLongCard extends StatelessWidget {
  const ProductLongCard(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.productId})
      : super(key: key);
  final String imageUrl;
  final String productId;
  final String name;

  @override
  Widget build(BuildContext context) {
    final logInState = context.read<log_in.LogInBloc>().state;
    return SizedBox(
      width: Utilities.screenWidth,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.network(imageUrl),
              kSpacing(10),
              Text(
                name,
                style: AppTextStyles.titileTextStyle,
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              if (logInState is log_in.Success) {
                context.read<DeleteProductBloc>().add(
                      DeleteFurnitureEvent(
                        productId: productId,
                        accessToken: logInState.userEntity.accessToken!,
                      ),
                    );
                context.read<ECommerceUserBloc>().add(
                      GetFurnitureFromUserIdEvent(
                        accessToken: logInState.userEntity.accessToken!,
                        userId: logInState.userEntity.id!,
                      ),
                    );
              }
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
