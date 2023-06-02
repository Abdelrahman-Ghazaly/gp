import 'package:flutter/material.dart';

import '../../features/auction/presentation/screens/auction_search_screen.dart';
import '../app_constants/app_constants.dart';
import '../utils/utilities.dart';

String searchCatigory = '';
String category = 'All';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    Key? key,
    required this.searchController,
    required this.maxPrice,
    required this.minPrice,
    required this.onPressed,
    this.hasHero = true,
  }) : super(key: key);
  final TextEditingController searchController;
  final TextEditingController maxPrice;
  final TextEditingController minPrice;
  final void Function() onPressed;
  final bool hasHero;

  @override
  Widget build(BuildContext context) {
    final width = Utilities.screenWidth;
    final height = Utilities.screenHeight;
    return Container(
      height: height * 0.07,
      width: width * 0.8,
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
            onPressed: onPressed,
            icon: const Icon(Icons.search),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: hasHero
                ? Hero(
                    tag: "Search",
                    child: SearchTextField(
                      height: height,
                      width: width,
                      searchController: searchController,
                    ),
                  )
                : SearchTextField(
                    height: height,
                    width: width,
                    searchController: searchController,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return DropdownButton<String>(
                                alignment: AlignmentDirectional.center,
                                value: category,
                                icon: const Icon(Icons.arrow_drop_down),
                                elevation: 16,
                                underline: Container(),
                                borderRadius: BorderRadius.circular(25),
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
                                items: searchCategory
                                    .map<DropdownMenuItem<String>>(
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
                          onPressed();
                        },
                        child: const Text('Done'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            icon: const Icon(
              Icons.filter_alt_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.height,
    required this.width,
    required this.searchController,
  });

  final double height;
  final double width;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: height * 0.06,
        width: width * 0.5,
        child: TextField(
          controller: searchController,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: AppColors.appBlackColor,
              ),
          decoration: InputDecoration(
            labelText: "Search",
            border: InputBorder.none,
            labelStyle: TextStyle(
              color: AppColors.appBlackColor.withOpacity(0.7),
              fontSize: 22,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
