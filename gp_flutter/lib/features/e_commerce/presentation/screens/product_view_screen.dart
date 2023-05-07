import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/e_commerce_bloc.dart';

import '../../../../core/app_constants/app_constants.dart';
import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/utils/utilities.dart';
import '../widgets/product_screen_widget/product_screen_widgets.dart';

class ProductViewScreen extends StatelessWidget {
  const ProductViewScreen({
    Key? key,
    required this.furnitureId,
  }) : super(key: key);
  final String furnitureId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBar(),
      body: BlocBuilder<ECommerceBloc, ECommerceState>(
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
                        itemCount: state.furnitureEntity?.imageUrls?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: Utilities.screenHeight * 0.4,
                            width: Utilities.screenWidth,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  state.furnitureEntity?.imageUrls?[index],
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
                      furnitureEntity: state.furnitureEntity!,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is Error) {
            return Text(state.message);
          } else {
            return LoadingWidget();
          }
        },
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
