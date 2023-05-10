import 'package:equatable/equatable.dart';

import 'seller_entity.dart';

class FurnitureEntity extends Equatable {
  final String? id;
  final String title;
  final String description;
  final List<dynamic>? imageUrls;
  final String? rawImage;
  final String category;
  final int price;
  final SellerEntity? sellerEntity;
  final String? sellerName;

  const FurnitureEntity({
    this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.category,
    required this.price,
    this.sellerEntity,
    this.rawImage,
    this.sellerName,
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      imageUrls,
      category,
      price,
      sellerEntity,
    ];
  }
}
