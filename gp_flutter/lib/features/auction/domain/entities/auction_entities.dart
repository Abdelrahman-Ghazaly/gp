import 'package:equatable/equatable.dart';

class AuctionEntities extends Equatable {
  final String userId;
  final String title;
  final String description;
  final List<String> image;
  final String category;
  final String duration;
  final String auctionId;
  final OwnerEntities? owner;
  final double startPrice;
  final double currentPrice;
  final bool isAccepted;
  final dynamic rawImage;
  final String winnerId;

  const AuctionEntities(
      {required this.auctionId,
      required this.owner,
      required this.isAccepted,
      required this.userId,
      required this.title,
      required this.currentPrice,
      required this.description,
      required this.image,
      required this.category,
      required this.duration,
      required this.startPrice,
      required this.winnerId,
      this.rawImage});

  @override
  List<Object> get props => [
        userId,
        title,
        description,
        image,
        category,
        startPrice,
        duration,
        currentPrice,
        auctionId,
        isAccepted,
        winnerId,
        owner!
      ];
}

class OwnerEntities {
  final String id;
  final String name;

  OwnerEntities({required this.id, required this.name});
}
