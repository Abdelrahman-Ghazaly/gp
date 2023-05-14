import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/app_constants/app_constants.dart';
import 'package:gp_flutter/core/common_widgets/app_bar.dart';
import 'package:gp_flutter/core/common_widgets/common_widgets.dart';
import 'package:gp_flutter/core/utils/utilities.dart';
import 'package:gp_flutter/features/authentication/presentation/screens/authentication_screen.dart';
import 'package:gp_flutter/features/e_commerce/presentation/widgets/widgets.dart';

import '../../../authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart'
    as log_in;
import '../bloc/user_product_bloc/user_product_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logInState = context.read<log_in.LogInBloc>().state;
    bool isLoggedIn = logInState is log_in.Success;
    if (isLoggedIn) {
      context.read<UserProductBloc>().add(
            GetFurnitureFromUserIdEvent(
              accessToken: logInState.userEntity.accessToken!,
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
                  BlocBuilder<UserProductBloc, UserProductState>(
                    builder: (context, state) {
                      if (state is Loaded) {
                        return Column(
                          children: List.generate(
                            state.furnitureEntities.length,
                            (index) => ItemCard(
                              furnitureEntity: state.furnitureEntities[index],
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
