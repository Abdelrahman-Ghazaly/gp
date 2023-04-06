import 'package:equatable/equatable.dart';

class FurnitureEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  //! will change from dynamic to String
  final List<dynamic>? imageUrls;
  final String? rawImage;
  final String category;
  final int price;
  final String sellerId;

  const FurnitureEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.category,
    required this.price,
    required this.sellerId,
    this.rawImage,
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
      sellerId,
    ];
  }
}
