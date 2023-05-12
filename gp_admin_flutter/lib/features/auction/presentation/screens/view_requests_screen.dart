import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/get_all_auctions_bloc/all_auctions_bloc.dart';
import '../widgets/auction_request_card.dart';

class ViewRequestsScreen extends StatelessWidget {
  const ViewRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AllAuctionsBloc>().add(GetAuctionProductsEvent());
    return Scaffold(
      body: BlocBuilder<AllAuctionsBloc, AllAuctionsState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Loaded) {
            return SingleChildScrollView(
              child: Column(
                children: List.generate(
                    state.auctionList.length,
                    (index) => Column(
                          children: [
                            AuctionRequestCard(
                              description: state.auctionList[index].description,
                              img: state.auctionList[index].image.first,
                              price: state.auctionList[index].startPrice
                                  .toString(),
                              title: state.auctionList[index].title,
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        )),
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
  }
}
