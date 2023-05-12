import '../../domain/entities/furniture_entity.dart';
import 'seller_model.dart';

class FurnitureModel extends FurnitureEntity {
  const FurnitureModel({
    super.id,
    required super.title,
    required super.description,
    super.imageUrls,
    required super.category,
    required super.price,
    required super.sellerEntity,
    super.rawImage,
    super.sellerName,
  });

  factory FurnitureModel.fromMap(Map<String, dynamic> map) {
    late bool ignor;
    if (map['user_id'] is String) {
      ignor = true;
    } else {
      ignor = false;
    }
    return FurnitureModel(
        id: map['_id'] ?? '',
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        imageUrls: map['imgURL'] ?? [],
        category: map['category'] ?? '',
        price: map['price'] ?? '',
        sellerEntity: ignor ? null : SellerModel.fromMap(map['user_id']),
        sellerName: map['seller']);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imgURL': rawImage,
      'category': category,
      'price': price,
    };
  }

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
