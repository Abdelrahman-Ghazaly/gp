import 'package:flutter/material.dart' hide AppBar;
import 'package:gp_flutter/core/app_constants/app_constants.dart';
import 'package:gp_flutter/core/utils/utilities.dart';

import '../../../../core/common_widgets/common_widgets.dart';
import '../../domain/entities/furniture_entity.dart';

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
          children: [
            SizedBox(
              height: Utilities.screenHeight * 0.4,
              width: Utilities.screenWidth,
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
            kSpacing20p,
            Text(
              furnitureEntity.title,
            )
          ],
        ),
      ),
    );
  }
}
