import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/app_constants/app_constants.dart';
import 'package:gp_flutter/core/common_widgets/common_widgets.dart';
import 'package:gp_flutter/core/utils/utilities.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/delete_product_bloc/delete_product_bloc.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/home_bloc/home_bloc.dart'
    as home;

import '../../../../authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart'
    as log_in;
import '../../bloc/e_commerce_user_bloc/e_commerce_user_bloc.dart'
    as e_commerce;

class ProductLongCard extends StatelessWidget {
  const ProductLongCard(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.productId,
      required this.isAuction})
      : super(key: key);
  final String imageUrl;
  final String productId;
  final String name;
  final bool isAuction;

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
                showDialog(
                  context: context,
                  builder: (context) {
                    delete() {
                      context.read<DeleteProductBloc>().add(
                            DeleteFurnitureEvent(
                              productId: productId,
                              accessToken: logInState.userEntity.accessToken!,
                              isAuction: isAuction,
                            ),
                          );
                      context.read<e_commerce.ECommerceUserBloc>().add(
                            e_commerce.GetFurnitureFromUserIdEvent(
                              accessToken: logInState.userEntity.accessToken!,
                              userId: logInState.userEntity.id!,
                            ),
                          );
                      context.read<home.HomeBloc>().add(
                            const home.GetPopularFurniturebyCategoryEvent(),
                          );
                    }

                    return Dialog(
                      child: SizedBox(
                        height: Utilities.screenHeight * 0.2,
                        child:
                            BlocBuilder<DeleteProductBloc, DeleteProductState>(
                          builder: (context, state) {
                            if (state is Loading) {
                              return const LoadingWidget();
                            } else if (state is Success) {
                              Navigator.pop(context);
                              return Container();
                            } else {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Are you sure you want to delete this product?',
                                    style: AppTextStyles.titileTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          delete();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        child: Text(
                                          'Yes',
                                          style: AppTextStyles.titileTextStyle
                                              .copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                        ),
                                        child: Text(
                                          'No',
                                          style: AppTextStyles.titileTextStyle
                                              .copyWith(
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
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
