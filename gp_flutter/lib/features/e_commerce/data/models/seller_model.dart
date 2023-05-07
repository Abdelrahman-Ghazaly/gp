import 'package:gp_flutter/features/e_commerce/domain/entities/seller_entity.dart';

class SellerModel extends SellerEntity {
  const SellerModel({
    required super.id,
    required super.name,
  });

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    return SellerModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
