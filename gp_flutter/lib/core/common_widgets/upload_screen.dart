import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  Future<XFile?> _loadImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  Uint8List? displayImage;

  _uploadData(BuildContext context) async {
    final logInState = context.read<LogInBloc>().state;
    if (logInState is Success) {
      XFile? rawImage = await _loadImage();

      if (!context.mounted) return;

      context.read<upload.UploadProductBloc>().add(
            upload.UploadFurnitureEvent(
              furniture: FurnitureModel(
                title: 'title',
                description: 'description',
                category: 'bed',
                price: 500,
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
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController name = TextEditingController();
    final TextEditingController description = TextEditingController();
    final TextEditingController price = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    final rawImage = await _loadImage();
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
                        ? const Icon(Icons.upload)
                        : Image.memory(
                            displayImage!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                FormTextField(
                  icon: Icons.chair,
                  labelText: 'Furniture Name',
                  controller: name,
                  keyboardType: TextInputType.name,
                ),
                FormTextField(
                  icon: Icons.edit,
                  labelText: 'Furniture Description',
                  controller: description,
                  keyboardType: TextInputType.name,
                  maxLines: 5,
                ),
                FormTextField(
                  icon: Icons.attach_money,
                  labelText: 'Furniture price',
                  controller: price,
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _uploadData(context);
                  },
                  child: const Text('Upload'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
