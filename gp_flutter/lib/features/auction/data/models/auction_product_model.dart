import '../../domain/entities/auction_entities.dart';

class AuctionProductModel extends AuctionEntities {
  const AuctionProductModel({
    required super.userId,
    required super.title,
    required super.currentPrice,
    required super.description,
    required super.image,
    required super.category,
    required super.duration,
    required super.startPrice,
    required super.auctionId,
    required super.owner,
    required super.isAccepted,
    super.rawImage,
    required super.winnerId,
  });

  factory AuctionProductModel.fromJson(Map<String, dynamic> json) {
    late bool ignor;
    if (json['owner_id'] is Map<String, dynamic>) {
      ignor = false;
    } else {
      ignor = true;
    }
    return AuctionProductModel(
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      currentPrice: json['current_pid'].toDouble() ?? 0,
      description: json['description'] ?? '',
      image: json['imgURL'].cast<String>() ?? [],
      category: json['category'] ?? '',
      duration: json['end_date'] ?? '',
      startPrice: json['start_price'].toDouble() ?? 0,
      auctionId: json['_id'] ?? '',
      owner: ignor ? null : OwnerModel.fromJson(json['owner_id']),
      isAccepted: json['is_accepted'] ?? false,
      winnerId: json['winner_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson(AuctionEntities product) => {
        'title': title,
        'description': description,
        'imgURL': rawImage,
        'category': category,
        'price': startPrice,
      };
}

class OwnerModel extends OwnerEntities {
  OwnerModel({required super.id, required super.name});

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
