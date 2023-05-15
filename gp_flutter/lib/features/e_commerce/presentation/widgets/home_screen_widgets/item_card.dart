import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/features/authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/app_constants/app_constants.dart';
import '../../../../../core/utils/utilities.dart';
import '../../../domain/entities/furniture_entity.dart';
import '../../bloc/favorite_bloc/favorite_bloc.dart';
import '../../bloc/product_view_bloc/product_view_bloc.dart';
import '../../screens/product_view_screen.dart';

bool _isFavorite = false;

class ItemCard extends StatefulWidget {
  const ItemCard({
    super.key,
    required this.furnitureEntity,
  });
  final FurnitureEntity furnitureEntity;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard>
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
  void dispose() {
    _isFavoriteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logInState = context.read<LogInBloc>().state;
    final isLogedIn = logInState is Success;

    return GestureDetector(
      onTap: () {
        context.read<ProductViewBloc>().add(
              GetFurnitureFromIdEvent(
                id: widget.furnitureEntity.id!,
              ),
            );
        Utilities().pushTo(
          context,
          screen: ProductViewScreen(
            furnitureId: widget.furnitureEntity.id!,
          ),
        );
      },
      child: Container(
        height: Utilities.screenHeight * 0.3,
        width: Utilities.screenHeight * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: Utilities.screenHeight * 0.15,
                width: Utilities.screenHeight * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.furnitureEntity.imageUrls!.first,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                widget.furnitureEntity.title,
                style: AppTextStyles.titileTextStyle,
              ),
              Text(
                widget.furnitureEntity.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: AppTextStyles.descriptionTextStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.furnitureEntity.price} EGP',
                    style: AppTextStyles.titileTextStyle.copyWith(
                      color: AppColors.appGreemColor,
                    ),
                  ),
                  FloatingActionButton.small(
                    onPressed: isLogedIn
                        ? () {
                            if (_isFavorite) {
                              context.read<FavoriteBloc>().add(
                                    DeleteFavoriteEvent(
                                      productId: widget.furnitureEntity.id!,
                                      accessToken:
                                          logInState.userEntity.accessToken!,
                                    ),
                                  );
                              _isFavoriteController.reverse();
                            } else {
                              context.read<FavoriteBloc>().add(
                                    AddFavoriteEvent(
                                      productId: widget.furnitureEntity.id!,
                                      accessToken:
                                          logInState.userEntity.accessToken!,
                                    ),
                                  );
                              _isFavoriteController.forward();
                            }
                            _isFavorite = !_isFavorite;
                          }
                        : null,
                    shape: const CircleBorder(),
                    backgroundColor: Colors.white,
                    elevation: 5,
                    child: Lottie.asset(
                      AppAnimations.lottieHeartAnimation,
                      controller: _isFavoriteController,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
