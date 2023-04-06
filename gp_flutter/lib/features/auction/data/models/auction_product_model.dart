import 'package:gp_flutter/features/auction/domain/entities/auction_product.dart';

class AuctionProductModel extends AuctionProduct {
  const AuctionProductModel(
      {required super.userId,
      required super.title,
      required super.currentPrice,
      required super.description,
      required super.image,
      required super.category,
      required super.duration,
      required super.startPrice});

  factory AuctionProductModel.fromJson(Map<String, dynamic> json) =>
      AuctionProductModel(
        userId: json['userId'],
        title: json['title'],
        currentPrice: json['currentPrice'].toDouble(),
        description: json['description'],
        image: json['image'],
        category: json['category'],
        duration: json['duration'],
        startPrice: json['startPrice'].toDouble(),
      );

  Map<String, dynamic> toJson(AuctionProduct product) => {
        "userId": product.userId,
        "title": product.title,
        "currentPrice": product.currentPrice,
        "description": product.description,
        "image": product.image,
        "category": product.category,
        "duration": product.duration,
        "startPrice": product.startPrice,
      };
}
