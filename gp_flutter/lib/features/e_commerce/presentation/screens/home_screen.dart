import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/e_commerce_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<ECommerceBloc, ECommerceState>(
          builder: (context, state) {
            if (state is Empty) {
              return Text('Empty');
            } else if (state is Loading) {
              return Text('Loading');
            } else if (state is Loaded) {
              return Text(state.furnitureList.length.toString());
            } else if (state is Error) {
              return Text(state.message);
            } else {
              return Text('Another State');
            }
          },
        ),
      ),
    );
  }
}
