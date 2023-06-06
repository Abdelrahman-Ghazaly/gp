import 'package:flutter/material.dart';

import 'package:gp_admin_flutter/features/reports/domain/entities/furniture_entity.dart';

import '../../../../core/app_constants/app_constants.dart';

import '../../../../core/utils/utilities.dart';

import '../widgets/product_details_form.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({
    Key? key,
    required this.furnitureEntity,
  }) : super(key: key);
  final FurnitureEntity furnitureEntity;

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
                  itemCount: widget.furnitureEntity.imageUrls?.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          height: Utilities.screenHeight * 0.4,
                          width: Utilities.screenWidth,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                widget.furnitureEntity.imageUrls?[index],
                              ),
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
                furnitureEntity: widget.furnitureEntity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
