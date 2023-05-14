import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_admin_flutter/core/utils/utilities.dart';

import '../../../authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart'
    as login_bloc;
import '../bloc/get_all_auctions_bloc/all_auctions_bloc.dart';
import '../widgets/auction_request_card.dart';

class ViewRequestsScreen extends StatelessWidget {
  const ViewRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<login_bloc.LogInBloc, login_bloc.LogInState>(
      builder: (context, loginState) {
        if (loginState is login_bloc.Loading) {
          return const Text("Loadin ");
        } else if (loginState is login_bloc.Success) {
          context.read<AllAuctionsBloc>().add(GetAuctionProductsEvent(
              adminToken: loginState.userEntity.accessToken!));
          return Scaffold(
            body: BlocBuilder<AllAuctionsBloc, AllAuctionsState>(
              builder: (context, state) {
                if (state is Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is Loaded) {
                  return SizedBox(
                    width: Utilities.screenWidth,
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                            state.auctionList.length,
                            (index) => Column(
                                  children: [
                                    AuctionRequestCard(
                                        productId:
                                            state.auctionList[index].auctionId,
                                        adminToken:
                                            loginState.userEntity.accessToken!,
                                        description: state
                                            .auctionList[index].description,
                                        img: state
                                            .auctionList[index].image.first,
                                        price: state
                                            .auctionList[index].startPrice
                                            .toString(),
                                        title: state.auctionList[index].title,
                                        auctionIndex: index),
                                    const SizedBox(
                                      height: 15,
                                    )
                                  ],
                                )),
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("Error"),
                  );
                }
              },
            ),
          );
        } else {
          return const Text("Loadin ");
        }
      },
    );
  }
}
