import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_constants/app_constants.dart';
import '../../../../core/utils/utilities.dart';
import '../../domain/entities/search_query_entity.dart';
import '../bloc/search_auctions_bloc/search_auctions_bloc.dart';

class AuctionSearchScreen extends StatelessWidget {
  const AuctionSearchScreen({super.key, required this.auctionSearch});
  final String auctionSearch;
  @override
  Widget build(BuildContext context) {
    final width = Utilities.screenWidth;
    final height = Utilities.screenHeight;
    String category = 'All';
    TextEditingController minPrice = TextEditingController();
    TextEditingController maxPrice = TextEditingController();
    TextEditingController searchController = TextEditingController();
    String searchCatigory = '';
    searchController.text = auctionSearch;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Container(
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
                      onPressed: () {
                        context.read<SearchAuctionsBloc>().add(
                            GetAuctionProductSearchEvent(
                                searchQueryEntity: SearchQueryEntity(
                                    name: searchController.text,
                                    category: searchCatigory,
                                    maxPrice: maxPrice.text,
                                    minPrice: minPrice.text)));
                      },
                      icon: const Icon(Icons.search)),
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
                            controller: searchController,
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
                                color: AppColors.appBlackColor.withOpacity(0.7),
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
                                        ),
                                        StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return DropdownButton<String>(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              value: category,
                                              icon: const Icon(
                                                  Icons.arrow_drop_down),
                                              elevation: 16,
                                              underline: Container(),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                                  ?.copyWith(fontSize: 15),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  category = value!;
                                                  if (value == 'All') {
                                                    searchCatigory = '';
                                                  } else {
                                                    searchCatigory = value;
                                                  }
                                                });
                                              },
                                              items: searchCategory.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        context.read<SearchAuctionsBloc>().add(
                                            GetAuctionProductSearchEvent(
                                                searchQueryEntity:
                                                    SearchQueryEntity(
                                                        name: searchController
                                                            .text,
                                                        category:
                                                            searchCatigory,
                                                        maxPrice: maxPrice.text,
                                                        minPrice:
                                                            minPrice.text)));
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
            SizedBox(
              height: height * 0.85,
              child: BlocBuilder<SearchAuctionsBloc, SearchAuctionsState>(
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
                                    GestureDetector(
                                      onTap: () => context.go(
                                          '/auction_details_screen?auction_id=${state.auctionList[index].auctionId}'),
                                      child: AuctionSearchCard(
                                        description: state
                                            .auctionList[index].description,
                                        img: state
                                            .auctionList[index].image.first,
                                        price: state
                                            .auctionList[index].currentPrice
                                            .toString(),
                                        title: state.auctionList[index].title,
                                      ),
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
            )
          ],
        ),
      ),
    );
  }
}

class AuctionSearchCard extends StatelessWidget {
  const AuctionSearchCard({
    super.key,
    required this.price,
    required this.title,
    required this.img,
    required this.description,
  });
  final String price;
  final String title;
  final String img;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: Utilities.screenHeight * 0.4,
        width: Utilities.screenWidth * 0.9,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          color: AppColors.appWhiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: Utilities.screenHeight * 0.25,
                width: Utilities.screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    begin: Alignment.center,
                    end: Alignment(0.8, 1),
                    colors: auctionLinearGradient,
                    tileMode: TileMode.mirror,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      img,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "Title: ",
                    style: AppTextStyles.titileTextStyle.copyWith(
                      color: AppColors.appGreemColor,
                    ),
                  ),
                  Text(
                    title,
                    style: AppTextStyles.titileTextStyle
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Description: ",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: AppTextStyles.titileTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appGreemColor,
                    ),
                  ),
                  SizedBox(
                    width: Utilities.screenWidth * 0.6,
                    child: Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: AppTextStyles.titileTextStyle
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Price: ',
                    style: AppTextStyles.titileTextStyle.copyWith(
                      color: AppColors.appGreemColor,
                    ),
                  ),
                  Text("$price EGP", style: AppTextStyles.titileTextStyle),
                ],
              ),
            ],
          ),
        ),
      ),
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
