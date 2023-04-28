import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/app_constants/api_constants.dart';

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
                  const HeaderText(title: 'Chair'),
                  kSpacing20p,
                  const ItemListView(
                    category: Category.chair,
                  ),
                  const HeaderText(title: 'Bed'),
                  kSpacing20p,
                  const ItemListView(
                    category: Category.bed,
                  ),
                  const HeaderText(title: 'Lamp'),
                  kSpacing20p,
                  const ItemListView(
                    category: Category.lamp,
                  ),
                  const HeaderText(title: 'Dresser'),
                  kSpacing20p,
                  const ItemListView(
                    category: Category.dresser,
                  ),
                  const HeaderText(title: 'Table'),
                  kSpacing20p,
                  const ItemListView(
                    category: Category.table,
                  ),
                  const HeaderText(title: 'Sofa'),
                  kSpacing20p,
                  const ItemListView(
                    category: Category.sofa,
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
