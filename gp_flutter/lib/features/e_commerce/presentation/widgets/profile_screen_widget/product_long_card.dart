import 'package:flutter/material.dart';
import 'package:gp_flutter/core/app_constants/app_constants.dart';
import 'package:gp_flutter/core/utils/utilities.dart';
import 'package:gp_flutter/features/e_commerce/presentation/screens/product_view_screen.dart';

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
            onPressed: () {},
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
