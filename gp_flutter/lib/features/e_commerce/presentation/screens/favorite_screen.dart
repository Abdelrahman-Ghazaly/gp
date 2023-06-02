import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/app_constants/app_constants.dart';
import 'package:gp_flutter/core/common_widgets/common_widgets.dart';
import 'package:gp_flutter/core/utils/utilities.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:gp_flutter/features/e_commerce/presentation/widgets/home_screen_widgets/home_screen_widgets.dart';
import '../../../authentication/presentation/screens/authentication_screen.dart';
import '../../../authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart'
    as log_in;

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logInState = context.read<log_in.LogInBloc>().state;
    final bool isLoggedIn = logInState is log_in.Success;

    if (isLoggedIn) {
      context.read<FavoriteBloc>().add(
            GetFavoriteEvent(
              accessToken: logInState.userEntity.accessToken!,
            ),
          );
      return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is LoadedFavorite) {
              return SizedBox(
                height: Utilities.screenHeight,
                width: Utilities.screenWidth,
                child: ListView.builder(
                  itemCount: state.furnitureEntities.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        kSpacing(20),
                        ItemCard(
                          furnitureEntity: state.furnitureEntities[index],
                          isFavorite: true,
                        ),
                        kSpacing(20),
                      ],
                    );
                  },
                ),
              );
            } else if (state is Error) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: LoadingWidget(),
              );
            }
          },
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(),
        body: const AuthenticationScreen(),
      );
    }
  }
}
