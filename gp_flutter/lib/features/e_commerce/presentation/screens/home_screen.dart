import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/app_constants/app_constants.dart';
import 'package:gp_flutter/features/e_commerce/data/data_sources/furniture_remote_data_source.dart';
import 'package:gp_flutter/features/e_commerce/data/models/furniture_model.dart';
import 'package:gp_flutter/features/e_commerce/data/repositories/e_commerce_repository_impl.dart';
import 'package:gp_flutter/features/e_commerce/domain/entities/furniture_entity.dart';
import 'package:gp_flutter/features/e_commerce/domain/entities/search_query_entity.dart';
import 'package:gp_flutter/features/e_commerce/domain/usecases/delete_product.dart';
import 'package:gp_flutter/features/e_commerce/domain/usecases/upload_furniture.dart';

import '../../../../main.dart';
import '../../domain/usecases/get_furnitire_from_search_by_category_and_price.dart';
import '../bloc/e_commerce_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FurnitureRemoteDataSourceImpl remoteDataSource =
        FurnitureRemoteDataSourceImpl();
    ECommerceRepositoryImpl repositoryImpl = ECommerceRepositoryImpl(
      remoteDataSource: remoteDataSource,
    );

    return Scaffold(
      body: BlocProvider(
        create: (context) => ECommerceBloc(
          uploadFurniture: UploadFurniture(repository: repositoryImpl),
        )..add(
            UploadFurnitureEvent(
              furniture: FurnitureModel(
                id: 'id',
                title: 'title',
                description: 'description',
                rawImage: base64String,
                category: 'category',
                price: 500,
                sellerId: 'sellerId',
              ),
            ),
          ),
        child: BlocBuilder<ECommerceBloc, ECommerceState>(
          builder: (context, state) {
            if (state is Loading) {
              print('loading');
            } else if (state is Error) {
              print(state.message);
            } else if (state is Loaded) {
              print(state.furnitureList[0].price);
            } else if (state is Empty) {
              print('Empty');
            }
            return Center(
              child: FloatingActionButton(
                onPressed: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
