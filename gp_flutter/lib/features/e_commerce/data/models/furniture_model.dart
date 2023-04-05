import '../../domain/entities/furniture_entity.dart';

class FurnitureModel extends FurnitureEntity {
  const FurnitureModel({
    required super.id,
    required super.title,
    required super.description,
    super.imageUrls,
    required super.category,
    required super.price,
    required super.sellerId,
    super.rawImage,
  });

  factory FurnitureModel.fromMap(Map<String, dynamic> map) {
    return FurnitureModel(
      id: map['_id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrls: map['imgURL'] ?? [],
      category: map['category'] ?? '',
      price: map['price'] ?? '',
      sellerId: map['user_id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'imgURL': rawImage,
      'category': category,
      'price': price,
//      'user_id': sellerId,
    };
  }
}
