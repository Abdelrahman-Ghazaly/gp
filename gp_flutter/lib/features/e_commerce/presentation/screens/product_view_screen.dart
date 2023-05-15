import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/app_constants/app_constants.dart';
import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/utils/utilities.dart';
import '../bloc/product_view_bloc/product_view_bloc.dart';
import '../widgets/product_screen_widget/product_screen_widgets.dart';

bool _isFavorite = false;

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({
    Key? key,
    required this.furnitureId,
  }) : super(key: key);
  final String furnitureId;

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _isFavoriteController;

  @override
  void initState() {
    super.initState();
    _isFavoriteController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 750,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProductViewBloc>().add(
          GetFurnitureFromIdEvent(id: widget.furnitureId),
        );
    return Scaffold(
      appBar: const CustomAppBar(),
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
                                  onPressed: () {
                                    if (_isFavorite) {
                                      _isFavoriteController.reverse();
                                    } else {
                                      _isFavoriteController.forward();
                                    }
                                    _isFavorite = !_isFavorite;
                                  },
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
