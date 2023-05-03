import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/features/auction/presentation/bloc/search_auctions_bloc/search_auctions_bloc.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/utils/utilities.dart';
import '../../domain/entities/search_query_entity.dart';

class AuctionSearchScreen extends StatelessWidget {
  const AuctionSearchScreen({super.key, required this.auctionSearch});
  final String auctionSearch;
  @override
  Widget build(BuildContext context) {
    final width = Utilities.screenWidth;
    final height = Utilities.screenHeight;
    TextEditingController minPrice = TextEditingController();
    TextEditingController maxPrice = TextEditingController();
    TextEditingController searchController = TextEditingController();
    searchController.text = auctionSearch;
    context.read<SearchAuctionsBloc>().add(
        GetAuctionProductSearchEvent(searchQueryEntity: SearchQueryEntity()));
    return BlocBuilder<SearchAuctionsBloc, SearchAuctionsState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Loaded) {
          return Scaffold(
            body: Center(
              child: Container(
                height: height * 0.07,
                width: width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: auctionLinearGradient,
                    tileMode: TileMode.mirror,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.search)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                        tag: "Search",
                        child: Material(
                          type: MaterialType.transparency,
                          child: SizedBox(
                            height: height * 0.06,
                            width: width * 0.65,
                            child: TextField(
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.appBlackColor),
                              decoration: InputDecoration(
                                labelText: "Search",
                                border: InputBorder.none,
                                labelStyle: TextStyle(
                                  color:
                                      AppColors.appBlackColor.withOpacity(0.7),
                                  fontSize: 22,
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () => showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(height: 5),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          PriceContainer(
                                            width: width,
                                            height: height,
                                            controller: minPrice,
                                            label: 'Minimum',
                                          ),
                                          PriceContainer(
                                            width: width,
                                            height: height,
                                            controller: maxPrice,
                                            label: 'Maximum',
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Done'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        icon: const Icon(Icons.filter_alt_outlined)),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }
}

class PriceContainer extends StatelessWidget {
  const PriceContainer(
      {super.key,
      required this.width,
      required this.height,
      required this.controller,
      required this.label});

  final double width;
  final double height;
  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.13,
      height: height * 0.07,
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
