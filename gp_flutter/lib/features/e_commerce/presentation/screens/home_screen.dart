import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_bloc/flutter_bloc.dart';

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
          const GetPopularFurniturebyCategoryEvent(
            category: Category.sofa,
          ),
        );
    context.read<ECommerceBloc>().add(
          const GetPopularFurniturebyCategoryEvent(
            category: Category.bed,
          ),
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
                  const HeaderText(title: 'Sofa'),
                  kSpacing20p,
                  SizedBox(
                    height: Utilities.screenHeight * 0.25,
                    width: Utilities.screenWidth,
                    child: Center(
                      child: BlocBuilder<ECommerceBloc, ECommerceState>(
                        builder: (context, state) {
                          if (state is Loaded) {
                            List<FurnitureEntity> furnitureList =
                                state.furnitureList;
                            return ListView.builder(
                              itemCount: furnitureList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.red,
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppTextStyles.headerTextStyle,
      ),
    );
  }
}
