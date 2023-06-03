import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_constants/app_constants.dart';
import '../../../../core/common_widgets/common_widgets.dart';
import '../../domain/entities/query_entity.dart';
import '../bloc/search_bloc/search_furniture_bloc.dart';
import '../widgets/widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController minPrice = TextEditingController();
    TextEditingController maxPrice = TextEditingController();
    TextEditingController searchController = TextEditingController();
    String searchCatigory = '';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomSearchBar(
          searchController: searchController,
          maxPrice: maxPrice,
          minPrice: minPrice,
          hasHero: false,
          onPressed: () {
            context.read<SearchBloc>().add(
                  GetFurnitireFromSearchEvent(
                    queryEntity: QueryEntity(
                      name: searchController.text,
                      category: searchCatigory,
                      maxPrice: maxPrice.text,
                      minPrice: minPrice.text,
                    ),
                  ),
                );
          },
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is Error) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is Empty) {
            return Container();
          } else if (state is Loaded) {
            return ListView.builder(
              itemCount: state.furnitureList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    kSpacing(20),
                    ItemCard(
                      furnitureEntity: state.furnitureList[index],
                    ),
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: LoadingWidget(),
            );
          }
        },
      ),
    );
  }
}
