import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_constants/app_values.dart';
import '../../../../../core/common_widgets/loading_widget.dart';
import '../../../../../core/utils/utilities.dart';
import '../../../../authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart'
    hide Error;
import '../../../domain/entities/furniture_entity.dart';
import '../../bloc/favorite_bloc/favorite_bloc.dart' hide Error;
import '../../bloc/home_bloc/home_bloc.dart';
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
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is Loaded) {
              final String key = category.mapToString();
              List<FurnitureEntity> furnitureList = state.furnitureMap[key]!;
              return ListView.builder(
                itemCount: furnitureList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final logInState = context.read<LogInBloc>().state;
                  final isLogedIn = logInState is Success;
                  final favState = context.read<FavoriteBloc>().state;
                  bool isFavorite = false;

                  if (isLogedIn) {
                    if (favState is LoadedFavorite) {
                      List<String> favIds = [];
                      for (var furniture in favState.furnitureEntities) {
                        favIds.add(furniture.id!);
                      }
                      isFavorite = favIds.contains(furnitureList[index].id);
                    } else {
                      isFavorite = false;
                    }
                  }

                  return Row(
                    children: [
                      ItemCard(
                        furnitureEntity: furnitureList[index],
                        isFavorite: isFavorite,
                      ),
                      kSpacing(20),
                    ],
                  );
                },
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
