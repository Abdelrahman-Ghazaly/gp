import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/home_bloc/home_bloc.dart';
import '../../bloc/product_view_bloc/product_view_bloc.dart';

import '../../../../../core/app_constants/app_constants.dart';
import '../../../../../core/utils/utilities.dart';
import '../../../domain/entities/furniture_entity.dart';
import '../../screens/product_view_screen.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.furnitureEntity,
  });
  final FurnitureEntity furnitureEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProductViewBloc>().add(
              GetFurnitureFromIdEvent(
                id: furnitureEntity.id,
              ),
            );
        Utilities().pushTo(
          context,
          screen: ProductViewScreen(
            furnitureId: furnitureEntity.id,
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
                      furnitureEntity.imageUrls!.first,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                furnitureEntity.title,
                style: AppTextStyles.titileTextStyle,
              ),
              Text(
                furnitureEntity.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: AppTextStyles.descriptionTextStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${furnitureEntity.price} EGP',
                    style: AppTextStyles.titileTextStyle.copyWith(
                      color: AppColors.appGreemColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.heart_fill,
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
