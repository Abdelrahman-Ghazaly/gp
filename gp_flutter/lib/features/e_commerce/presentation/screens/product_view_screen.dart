import 'package:flutter/material.dart' hide AppBar;

import '../../../../core/app_constants/app_constants.dart';
import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/utils/utilities.dart';
import '../../domain/entities/furniture_entity.dart';
import '../widgets/product_screen_widget/product_screen_widgets.dart';

class ProductViewScreen extends StatelessWidget {
  const ProductViewScreen({
    Key? key,
    required this.furnitureEntity,
  }) : super(key: key);
  final FurnitureEntity furnitureEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBar(),
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
                  itemCount: furnitureEntity.imageUrls?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: Utilities.screenHeight * 0.4,
                      width: Utilities.screenWidth,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            furnitureEntity.imageUrls?[index],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ProductDetailsForm(
                furnitureEntity: furnitureEntity,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ProductViewBottomNavBar(),
    );
  }
}

//  SizedBox(
//               height: Utilities.screenHeight * 0.4,
//               width: Utilities.screenWidth,
//               child: PageView.builder(
//                 itemCount: furnitureEntity.imageUrls?.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     height: Utilities.screenHeight * 0.4,
//                     width: Utilities.screenWidth,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           furnitureEntity.imageUrls?[index],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
