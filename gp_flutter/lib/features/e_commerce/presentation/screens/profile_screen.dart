import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/features/e_commerce/presentation/widgets/profile_screen_widget/product_long_card.dart';

import '../../../../core/app_constants/app_constants.dart';
import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/utils/utilities.dart';
import '../../../authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart'
    as log_in;
import '../../../authentication/presentation/screens/authentication_screen.dart';
import '../bloc/e_commerce_user_bloc/e_commerce_user_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logInState = context.read<log_in.LogInBloc>().state;
    bool isLoggedIn = logInState is log_in.Success;
    if (isLoggedIn) {
      context.read<ECommerceUserBloc>().add(
            GetFurnitureFromUserIdEvent(
              accessToken: logInState.userEntity.accessToken!,
              userId: logInState.userEntity.id!,
            ),
          );
    }
    return Scaffold(
      body: isLoggedIn
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Utilities.screenHeight * 0.25,
                    width: Utilities.screenWidth,
                    child: Stack(
                      children: [
                        Container(
                          height: Utilities.screenHeight * 0.2,
                          width: Utilities.screenWidth,
                          decoration: const BoxDecoration(
                            color: AppColors.appGreyColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                AppImages.profilBackground,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: Utilities.screenWidth * 0.4,
                          child: CircleAvatar(
                            radius: Utilities.screenWidth * 0.1,
                            backgroundImage: const AssetImage(
                              AppImages.profilImage,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  kSpacing(20),
                  const Text('Name'),
                  Text(logInState.userEntity.name),
                  kSpacing(20),
                  const Text('E-Mail'),
                  Text(logInState.userEntity.email),
                  kSpacing(20),
                  const Text('Address'),
                  Text(logInState.userEntity.address),
                  kSpacing(20),
                  const Text('Phone Number'),
                  Text(logInState.userEntity.phoneNumber),
                  kSpacing(20),
                  BlocBuilder<ECommerceUserBloc, ECommerceUserState>(
                    builder: (context, state) {
                      if (state is Loaded) {
                        return SizedBox(
                          height: Utilities.screenHeight * 0.35,
                          width: Utilities.screenWidth,
                          child: ListView.builder(
                            itemCount: state.productList.length,
                            itemBuilder: (context, index) => Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ProductLongCard(
                                    name: state.productList[index].title,
                                    imageUrl: state
                                        .productList[index].imageUrls!.first,
                                    productId: state.productList[index].id!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (state is Error) {
                        return Text(state.message);
                      } else {
                        return const Center(
                          child: LoadingWidget(),
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          : const AuthenticationScreen(),
    );
  }
}
