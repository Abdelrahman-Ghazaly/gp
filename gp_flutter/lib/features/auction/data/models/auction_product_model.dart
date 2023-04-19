import '../../domain/entities/auction_entities.dart';

class AuctionProductModel extends AuctionEntities {
  const AuctionProductModel(
      {required super.userId,
      required super.title,
      required super.currentPrice,
      required super.description,
      required super.image,
      required super.category,
      required super.duration,
      required super.startPrice,
      required super.auctionId,
      required super.seller,
      required super.isAccepted});

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
        auctionId: json['duration'],
        seller: '',
        isAccepted: json['duration'],
      );

  Map<String, dynamic> toJson(AuctionEntities product) => {
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
