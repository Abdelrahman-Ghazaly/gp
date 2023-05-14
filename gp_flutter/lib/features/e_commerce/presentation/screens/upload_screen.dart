import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart';
import '../../data/models/furniture_model.dart';
import '../../domain/entities/seller_entity.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/upload_product_bloc/upload_product_bloc.dart'
    as upload;
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  _loadImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await _uploadData();
        },
        child: const Text('Upload'),
      ),
    );
  }

  _uploadData() async {
    final logInState = context.read<LogInBloc>().state;
    if (logInState is Success) {
      var rawImage = await _loadImage();

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
}
