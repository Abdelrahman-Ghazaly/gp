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
      required super.owner,
      required super.isAccepted});

  factory AuctionProductModel.fromJson(Map<String, dynamic> json) =>
      AuctionProductModel(
        userId: json['userId'] ?? "",
        title: json['title'] ?? "",
        currentPrice: json['current_pid'].toDouble() ?? 0,
        description: json['description'] ?? "",
        image: json['imgURL'].cast<String>() ?? [],
        category: json['category'] ?? "",
        duration: json['end_date'] ?? "",
        startPrice: json['start_price'].toDouble() ?? 0,
        auctionId: json['_id'] ?? "",
        owner: OwnerModel.fromJson(json['owner_id']),
        isAccepted: json['is_accepted'] ?? false,
      );

  Map<String, dynamic> toJson(AuctionEntities product) => {
        "userId": product.userId,
        "title": product.title,
        "currentPrice": product.currentPrice,
        "description": product.description,
        "image": product.image,
        "category": product.category,
        "duration": product.duration,
        "startPrice": product.startPrice
      };
}

class OwnerModel extends OwnerEntities {
  OwnerModel({required super.id, required super.name});

  factory OwnerModel.fromJson(Map<String, dynamic>? json) {
    json ??= {"_id": "", "name": ""};
    return OwnerModel(
      id: json['_id'] ?? "",
      name: json['name'] ?? "",
    );
  }

  Map<String, dynamic> toJson(OwnerEntities owner) => {
        "_id": owner.id,
        "name": owner.name,
      };
}
