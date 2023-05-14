import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp_flutter/core/utils/utilities.dart';
import 'package:gp_flutter/features/e_commerce/presentation/screens/search_screen.dart';

import '../../features/e_commerce/presentation/screens/favorite_screen.dart';
import '../app_constants/app_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.black.withOpacity(0.4),
      elevation: 5,
      title: Text(
        'Furniture',
        style: AppTextStyles.appBarTextStyle,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Utilities().pushTo(
              context,
              screen: const FavoriteScreen(),
              withNavBar: false,
            );
          },
          icon: const Icon(
            CupertinoIcons.heart_fill,
          ),
        ),
        IconButton(
          onPressed: () {
            Utilities().pushTo(
              context,
              screen: const SearchScreen(),
              withNavBar: false,
            );
          },
          icon: const Icon(CupertinoIcons.search),
        ),
      ],
    );
  }
}
