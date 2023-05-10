import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Utilities {
  static final double screenHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;

  static final double screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

  pushAndReplace({required BuildContext context, required Widget screen}) {
    Future.delayed(
      Duration.zero,
      () {
        Navigator.pushReplacement(
          context,
          _MyRoute(
            builder: (context) => screen,
          ),
        );
      },
    );
  }

  pushTo(
    BuildContext context, {
    required Widget screen,
    bool withNavBar = false,
  }) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: screen,
      withNavBar: withNavBar,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  pop({required BuildContext context}) {
    Future.delayed(
      Duration.zero,
      () {
        Navigator.pop(
          context,
        );
      },
    );
  }
}

class _MyRoute extends CupertinoPageRoute {
  _MyRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);
}
