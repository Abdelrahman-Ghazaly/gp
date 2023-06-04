import '../../domain/entities/furniture_entity.dart';

class FurnitureModel extends FurnitureEntity {
  const FurnitureModel({
    required super.title,
    required super.description,
    super.imageUrls,
    required super.category,
    required super.price,
  });

  factory FurnitureModel.fromMap(Map<String, dynamic> map) {
    return FurnitureModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrls: map['imgURL'] ?? [],
      category: map['category'] ?? '',
      price: map['price'] ?? 0,
    );
  }

  @override
  List<Object?> get props {
    return [
      title,
      description,
      imageUrls,
      category,
      price,
    ];
  }
}
