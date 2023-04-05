import 'package:equatable/equatable.dart';

class FurnitureEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final List<String> imageUrls;
  final String category;
  final String price;
  final String sellerId;

  const FurnitureEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.category,
    required this.price,
    required this.sellerId,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      imageUrls,
      category,
      price,
      sellerId,
    ];
  }
}
