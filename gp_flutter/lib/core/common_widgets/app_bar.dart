import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp_flutter/core/app_constants/app_constants.dart';
import 'package:lottie/lottie.dart';

class AppBar extends StatelessWidget with PreferredSizeWidget {
  const AppBar({Key? key})
      : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight,
      //TODO: change when Osama's code is pushed
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Furniture',
                style: kAppBarTextStyle,
              ),
              Row(
                children: [
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
            ],
          ),
        ),
      ),
    );
  }
}