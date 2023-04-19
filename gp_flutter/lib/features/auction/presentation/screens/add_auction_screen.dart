import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddAuction extends StatefulWidget {
  const AddAuction({Key? key}) : super(key: key);

  @override
  State<AddAuction> createState() => _AddAuctionState();
}

class _AddAuctionState extends State<AddAuction> {
  final TextEditingController auctionNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  @override
  void dispose() {
    super.dispose();
    auctionNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  String category = 'Mobiles';
  List<File> images = [];
  final _addAuctionFormKey = GlobalKey<FormState>();

  void selectImages() async {
    final List<XFile> images = await picker.pickMultiImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
/*
 final bytes = File(image!.path).readAsBytesSync();
                          String base64Image =  "data:image/png;base64,"+base64Encode(bytes);

                          print("img_pan : $base64Image");
*/
