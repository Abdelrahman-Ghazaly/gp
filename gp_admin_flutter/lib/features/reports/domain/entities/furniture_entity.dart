import 'package:equatable/equatable.dart';

class FurnitureEntity extends Equatable {
  final String title;
  final String description;
  final List<dynamic>? imageUrls;
  final String category;
  final int price;

  const FurnitureEntity({
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.category,
    required this.price,
  });

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
