import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/features/authentication/domain/entities/user_entity.dart';
import 'package:gp_flutter/features/authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart';
import 'package:gp_flutter/features/e_commerce/data/models/furniture_model.dart';
import 'package:gp_flutter/features/e_commerce/domain/entities/seller_entity.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/upload_product_bloc/upload_product_bloc.dart'
    as upload;

class UploadScreen extends StatelessWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logInState = context.read<LogInBloc>().state;
    if (logInState is Success) {
      context.read<upload.UploadProductBloc>().add(
            upload.UploadFurnitureEvent(
              furniture: FurnitureModel(
                title: 'title',
                description: 'description',
                category: 'bed',
                price: 500,
                sellerEntity: SellerEntity(
                  id: logInState.userEntity.id!,
                  name: logInState.userEntity.name,
                ),
              ),
              userEntity: logInState.userEntity,
            ),
          );
    }
    return Container();
  }
}
