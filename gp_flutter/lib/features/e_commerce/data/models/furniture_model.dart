import '../../domain/entities/furniture_entity.dart';

class FurnitureModel extends FurnitureEntity {
  const FurnitureModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.category,
    required super.price,
    required super.sellerId,
  });

  factory FurnitureModel.fromMap(Map<String, dynamic> map) {
    return FurnitureModel(
      id: map['_id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imgURL'] ?? '',
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
      'imgURL': imageUrl,
      'category': category,
      'price': price,
      'user_id': sellerId,
    };
  }
}
