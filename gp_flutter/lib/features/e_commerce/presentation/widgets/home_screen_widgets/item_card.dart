import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp_flutter/features/e_commerce/domain/entities/furniture_entity.dart';

import '../../../../../core/utils/utilities.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.furnitureEntity,
  });
  final FurnitureEntity furnitureEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          Container(
            height: Utilities.screenHeight * 0.2,
            width: Utilities.screenHeight * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  furnitureEntity.imageUrls![0],
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            furnitureEntity.title,
          ),
          Text(
            furnitureEntity.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          Row(children: [
            Text(
              furnitureEntity.price.toString(),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.heart_fill,
              ),
            )
          ]),
        ],
      ),
    );
  }
}
