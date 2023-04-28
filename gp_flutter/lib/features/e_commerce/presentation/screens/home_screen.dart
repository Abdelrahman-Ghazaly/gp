import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_constants/api_constants.dart';

import '../../../../core/app_constants/app_constants.dart';
import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/utils/utilities.dart';
import '../../domain/entities/furniture_entity.dart';
import '../bloc/e_commerce_bloc.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ECommerceBloc>().add(
          const GetPopularFurniturebyCategoryEvent(),
        );

    return Scaffold(
      appBar: const AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BannerWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                children: [
                  const HeaderText(title: 'Our Categories'),
                  kSpacing20p,
                  SizedBox(
                    height: Utilities.screenHeight * 0.1,
                    child: const Placeholder(),
                  ),
                  kSpacing20p,
                  ...List.generate(
                    Category.values.length,
                    (index) {
                      final String categoryName =
                          mapCategoryToString(Category.values[index]);
                      return Column(
                        children: [
                          HeaderText(
                            title: categoryName[0].toUpperCase() +
                                categoryName.substring(1).toLowerCase(),
                          ),
                          kSpacing20p,
                          ItemListView(
                            category: Category.values[index],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
