import 'package:flutter/cupertino.dart';

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


}

class _MyRoute extends CupertinoPageRoute {
  _MyRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);
}
