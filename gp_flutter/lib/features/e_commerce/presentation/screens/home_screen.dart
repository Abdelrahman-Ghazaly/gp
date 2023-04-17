import 'package:flutter/material.dart' hide AppBar;
import 'package:gp_flutter/core/common_widgets/common_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBar(),
      body: Column(
        children: [],
      ),
    );
  }
}
