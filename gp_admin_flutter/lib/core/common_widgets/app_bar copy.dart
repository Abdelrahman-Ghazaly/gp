import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_constants/app_constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.4),
        elevation: 5,
        title: Text(
          'Furniture',
          style: AppTextStyles.appBarTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.heart_fill,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.search),
          ),
        ],
      ),
    );
  }
}
