import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/features/authentication/presentation/screens/authentication_screen.dart';
import '../app_constants/app_constants.dart';
import '../utils/utilities.dart';
import '../../features/authentication/presentation/widgets/form_text_field.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/upload_product_bloc/upload_product_bloc.dart'
    as upload;
import 'package:image_picker/image_picker.dart';

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
  final TextEditingController category = TextEditingController();

  Future<XFile?> _loadImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  Uint8List? displayImage;
  XFile? rawImage;

  _uploadData(BuildContext context) async {
    final logInState = context.read<LogInBloc>().state;
    if (logInState is Success) {
      if (!context.mounted) return;

      context.read<upload.UploadProductBloc>().add(
            upload.UploadFurnitureEvent(
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

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.read<LogInBloc>().state is Success;
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
                        labelText: 'Furniture Name',
                        controller: name,
                        keyboardType: TextInputType.name,
                      ),
                      kSpacing(20),
                      FormTextField(
                        icon: Icons.edit,
                        labelText: 'Furniture Description',
                        controller: description,
                        keyboardType: TextInputType.name,
                        maxLines: 5,
                      ),
                      kSpacing(20),
                      DropdownMenu(
                        leadingIcon: const Icon(Icons.category),
                        width: Utilities.screenWidth,
                        label: const Text('Furniture Category'),
                        dropdownMenuEntries: categoryList,
                        controller: category,
                      ),
                      kSpacing(20),
                      FormTextField(
                        icon: Icons.attach_money,
                        labelText: 'Furniture price',
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
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate() ||
                              category.text.isNotEmpty) {
                            await _uploadData(context);
                          }
                        },
                        child: const Text('Upload'),
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
