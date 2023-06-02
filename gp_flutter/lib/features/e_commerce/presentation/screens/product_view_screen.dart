import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/app_constants/app_constants.dart';
import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/utils/utilities.dart';
import '../../../authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart'
    as log_in;
import '../bloc/favorite_bloc/favorite_bloc.dart' as fav;
import '../bloc/product_view_bloc/product_view_bloc.dart';
import '../widgets/product_screen_widget/product_screen_widgets.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({
    Key? key,
    required this.furnitureId,
    required this.isFavorite,
    required this.callBack,
  }) : super(key: key);
  final String furnitureId;
  final bool isFavorite;
  final Function callBack;

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _isFavoriteController;
  late bool _isFavorite = widget.isFavorite;
  @override
  void initState() {
    super.initState();
    _isFavoriteController = AnimationController(
      value: _isFavorite ? 1 : 0,
      vsync: this,
      duration: const Duration(
        milliseconds: 750,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final logInState = context.read<log_in.LogInBloc>().state;
    final isLogedIn = logInState is log_in.Success;

    context.read<ProductViewBloc>().add(
          GetFurnitureFromIdEvent(id: widget.furnitureId),
        );
    return Scaffold(
      body: BlocBuilder<ProductViewBloc, ProductViewState>(
        builder: (context, state) {
          if (state is Loaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Utilities.screenWidth,
                    height: Utilities.screenHeight * 0.5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment(0.8, 1),
                        colors: auctionDetailsLinearGradient,
                        tileMode: TileMode.mirror,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: PageView.builder(
                        itemCount: state.furnitureEntity.imageUrls?.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                height: Utilities.screenHeight * 0.4,
                                width: Utilities.screenWidth,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      state.furnitureEntity.imageUrls?[index],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton.small(
                                  onPressed: isLogedIn
                                      ? () {
                                          if (_isFavorite) {
                                            context
                                                .read<fav.FavoriteBloc>()
                                                .add(
                                                  fav.DeleteFavoriteEvent(
                                                    productId:
                                                        widget.furnitureId,
                                                    accessToken: logInState
                                                        .userEntity
                                                        .accessToken!,
                                                  ),
                                                );
                                            _isFavoriteController.reverse();
                                          } else {
                                            context
                                                .read<fav.FavoriteBloc>()
                                                .add(
                                                  fav.AddFavoriteEvent(
                                                    productId:
                                                        widget.furnitureId,
                                                    accessToken: logInState
                                                        .userEntity
                                                        .accessToken!,
                                                  ),
                                                );
                                            _isFavoriteController.forward();
                                          }
                                          _isFavorite = !_isFavorite;
                                          widget.callBack(_isFavorite);
                                        }
                                      : null,
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.white,
                                  child: Lottie.asset(
                                    AppAnimations.lottieHeartAnimation,
                                    controller: _isFavoriteController,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ProductDetailsForm(
                      furnitureEntity: state.furnitureEntity,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is Error) {
            return Text(state.message);
          } else {
            return const LoadingWidget();
          }
        },
      ),
      bottomNavigationBar: const ProductViewBottomNavBar(),
    );
  }
}
