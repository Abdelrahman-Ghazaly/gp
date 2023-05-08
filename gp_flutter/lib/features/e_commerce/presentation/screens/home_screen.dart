import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc/home_bloc.dart';

import '../../../../core/app_constants/app_constants.dart';
import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/utils/utilities.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(
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
                  kSpacing(20),
                  SizedBox(
                    height: Utilities.screenHeight * 0.1,
                    child: const Placeholder(),
                  ),
                  kSpacing(20),
                  ...List.generate(
                    Category.values.length,
                    (index) {
                      final String categoryName =
                          Category.values[index].mapToString();
                      return Column(
                        children: [
                          HeaderText(
                            title: categoryName[0].toUpperCase() +
                                categoryName.substring(1).toLowerCase(),
                          ),
                          kSpacing(20),
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
