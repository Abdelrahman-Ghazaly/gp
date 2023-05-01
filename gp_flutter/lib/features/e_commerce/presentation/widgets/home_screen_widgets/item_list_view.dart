import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_constants/api_constants.dart';
import '../../../../../core/app_constants/app_values.dart';
import '../../../../../core/common_widgets/loading_widget.dart';
import '../../../../../core/utils/utilities.dart';
import '../../../domain/entities/furniture_entity.dart';
import '../../bloc/e_commerce_bloc.dart';
import 'item_card.dart';

class ItemListView extends StatelessWidget {
  const ItemListView({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Utilities.screenHeight * 0.35,
      width: Utilities.screenWidth,
      child: Center(
        child: BlocBuilder<ECommerceBloc, ECommerceState>(
          builder: (context, state) {
            if (state is Loaded) {
              final String key = mapCategoryToString(category);
              List<FurnitureEntity> furnitureList = state.furnitureMap![key]!;
              return ListView.builder(
                itemCount: furnitureList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Row(
                  children: [
                    ItemCard(
                      furnitureEntity: furnitureList[index],
                    ),
                    kSpacing20p,
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
      ),
    );
  }
}
