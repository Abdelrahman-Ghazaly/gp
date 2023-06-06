import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/common_widgets/common_widgets.dart';
import 'package:gp_flutter/features/auction/domain/entities/auction_entities.dart';
import 'package:gp_flutter/features/authentication/presentation/screens/authentication_screen.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/e_commerce_user_bloc/e_commerce_user_bloc.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/home_bloc/home_bloc.dart';
import '../app_constants/app_constants.dart';
import '../utils/utilities.dart';
import '../../features/authentication/presentation/widgets/form_text_field.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/upload_product_bloc/upload_product_bloc.dart'
    as upload_product;
import 'package:image_picker/image_picker.dart';
import 'package:gp_flutter/features/auction/presentation/bloc/upload_auction_bloc/upload_auction_bloc.dart'
    as upload_auction;
import '../../features/authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart';
import '../../features/e_commerce/data/models/furniture_model.dart';
import '../../features/e_commerce/domain/entities/seller_entity.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController category = TextEditingController();
  bool isAuction = false;

  Future<XFile?> _loadImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  Uint8List? displayImage;
  XFile? rawImage;

  _uploadData(BuildContext context) async {
    final logInState = context.read<LogInBloc>().state;
    if (logInState is Success) {
      if (!context.mounted) return;
      if (isAuction) {
        int houreNum = int.parse(duration.text) * 60 * 60 * 1000;

        context.read<upload_auction.UploadAuctionBloc>().add(
              upload_auction.UploadAuctionEvent(
                auctionEntities: AuctionEntities(
                  title: name.text,
                  description: description.text,
                  category: category.text.toLowerCase(),
                  startPrice: double.parse(price.text),
                  rawImage: rawImage,
                  auctionId: '',
                  currentPrice: 0,
                  duration: houreNum.toString(),
                  image: [],
                  isAccepted: false,
                  owner: null,
                  userId: '',
                ),
                userToken: logInState.userEntity.accessToken!,
              ),
            );
      } else {
        context.read<upload_product.UploadProductBloc>().add(
              upload_product.UploadFurnitureEvent(
                furniture: FurnitureModel(
                  title: name.text,
                  description: description.text,
                  category: category.text.toLowerCase(),
                  price: num.tryParse(price.text) as int,
                  rawImage: rawImage,
                  sellerEntity: SellerEntity(
                    id: logInState.userEntity.id!,
                    name: logInState.userEntity.name,
                  ),
                ),
                userEntity: logInState.userEntity,
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final logInState = context.read<LogInBloc>().state;
    final isLoggedIn = logInState is Success;
    return Scaffold(
      body: isLoggedIn
          ? SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          rawImage = await _loadImage();
                          displayImage = await rawImage?.readAsBytes();
                          setState(() {});
                        },
                        child: Container(
                          height: Utilities.screenWidth * 0.5,
                          width: Utilities.screenWidth * 0.5,
                          decoration: BoxDecoration(
                            color: AppColors.appGreyColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: displayImage == null
                              ? const Icon(
                                  Icons.upload,
                                  size: 50,
                                )
                              : Image.memory(
                                  displayImage!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      kSpacing(20),
                      FormTextField(
                        icon: Icons.chair,
                        labelText: 'Product Name',
                        controller: name,
                        keyboardType: TextInputType.name,
                      ),
                      kSpacing(20),
                      FormTextField(
                        icon: Icons.edit,
                        labelText: 'Product Description',
                        controller: description,
                        keyboardType: TextInputType.name,
                        maxLines: 5,
                      ),
                      kSpacing(20),
                      Visibility(
                        visible: isAuction,
                        child: DropdownMenu(
                          leadingIcon: const Icon(Icons.category),
                          width: Utilities.screenWidth,
                          label: const Text('Product Category'),
                          dropdownMenuEntries: categoryList,
                          onSelected: (value) => category.text = value,
                        ),
                      ),
                      kSpacing(20),
                      FormTextField(
                        icon: Icons.attach_money,
                        labelText: 'Product price',
                        controller: price,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          var price = num.tryParse(value!);
                          if (price == null || price <= 0) {
                            return 'Please enter a valid price';
                          } else if (price.runtimeType == double) {
                            return 'Please enter a whole number';
                          }
                          return null;
                        },
                      ),
                      kSpacing(20),
                      Visibility(
                        visible: isAuction,
                        child: FormTextField(
                          icon: Icons.timelapse_outlined,
                          labelText: 'Number Of Hours',
                          controller: duration,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            var price = num.tryParse(value!);
                            if (price == null) {
                              return 'Please enter a valid Number Of Hours';
                            } else if (price.runtimeType == double) {
                              return 'Please enter a whole Number Of Hours';
                            }
                            return null;
                          },
                        ),
                      ),
                      kSpacing(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Auction"),
                          Checkbox(
                            checkColor: Colors.white,
                            value: isAuction,
                            onChanged: (bool? value) {
                              setState(() {
                                duration = TextEditingController();
                                isAuction = value!;
                              });
                            },
                          ),
                          kSpacing(20),
                        ],
                      ),
                      kSpacing(20),
                      BlocListener<upload_product.UploadProductBloc,
                          upload_product.UploadProductState>(
                        listener: (context, state) {
                          if (state is upload_product.Error) {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: Center(
                                  child: Text(state.message),
                                ),
                              ),
                            );
                            setState(() {
                              name.clear();
                              description.clear();
                              displayImage = null;
                              rawImage = null;
                              category.clear();
                              price.clear();
                            });
                          } else if (state is upload_product.Success) {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: Center(
                                  child: Text(state.message),
                                ),
                              ),
                            );
                            setState(() {
                              name.clear();
                              description.clear();
                              displayImage = null;
                              rawImage = null;
                              category.clear();
                              price.clear();
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => const Dialog(
                                child: Center(
                                  child: LoadingWidget(),
                                ),
                              ),
                            );
                            setState(() {
                              name.clear();
                              description.clear();
                              displayImage = null;
                              rawImage = null;
                              category.clear();
                              price.clear();
                            });
                          }
                        },
                        child: Visibility(
                          visible: !isAuction,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate() ||
                                  category.text.isNotEmpty) {
                                await _uploadData(context);

                                if (!mounted) return;

                                context.read<HomeBloc>().add(
                                      const GetPopularFurniturebyCategoryEvent(),
                                    );
                                context.read<ECommerceUserBloc>().add(
                                      GetFurnitureFromUserIdEvent(
                                        accessToken:
                                            logInState.userEntity.accessToken!,
                                        userId: logInState.userEntity.id!,
                                      ),
                                    );
                              }
                            },
                            child: const Text('Upload'),
                          ),
                        ),
                      ),
                      BlocListener<upload_auction.UploadAuctionBloc,
                          upload_auction.UploadAuctionState>(
                        listener: (context, state) {
                          if (state is upload_auction.Error) {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: Center(
                                  child: Text(state.message),
                                ),
                              ),
                            );
                            setState(() {
                              name.clear();
                              description.clear();
                              displayImage = null;
                              rawImage = null;
                              category.clear();
                              price.clear();
                              duration.clear();
                            });
                          } else if (state is upload_auction.Success) {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: Center(
                                  child: Text(state.message),
                                ),
                              ),
                            );
                            setState(() {
                              name.clear();
                              description.clear();
                              displayImage = null;
                              rawImage = null;
                              category.clear();
                              price.clear();
                              duration.clear();
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => const Dialog(
                                child: Center(
                                  child: LoadingWidget(),
                                ),
                              ),
                            );
                            setState(() {
                              name.clear();
                              description.clear();
                              displayImage = null;
                              rawImage = null;
                              category.clear();
                              price.clear();
                              duration.clear();
                            });
                          }
                        },
                        child: Visibility(
                          visible: isAuction,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate() ||
                                  category.text.isNotEmpty) {
                                await _uploadData(context);

                                if (!mounted) return;

                                context.read<HomeBloc>().add(
                                      const GetPopularFurniturebyCategoryEvent(),
                                    );
                                context.read<ECommerceUserBloc>().add(
                                      GetFurnitureFromUserIdEvent(
                                        accessToken:
                                            logInState.userEntity.accessToken!,
                                        userId: logInState.userEntity.id!,
                                      ),
                                    );
                              }
                            },
                            child: const Text('Upload'),
                          ),
                        ),
                      ),
                      kSpacing(20),
                    ],
                  ),
                ),
              ),
            )
          : const AuthenticationScreen(),
    );
  }
}

const List<DropdownMenuEntry> categoryList = [
  DropdownMenuEntry(value: 'bed', label: 'Bed'),
  DropdownMenuEntry(value: 'chair', label: 'Chair'),
  DropdownMenuEntry(value: 'dresser', label: 'Dresser'),
  DropdownMenuEntry(value: 'lamp', label: 'Lamp'),
  DropdownMenuEntry(value: 'sofa', label: 'Sofa'),
  DropdownMenuEntry(value: 'table', label: 'Table'),
];
