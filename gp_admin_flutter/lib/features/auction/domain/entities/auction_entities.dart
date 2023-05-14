import 'package:equatable/equatable.dart';

class AuctionEntities extends Equatable {
  final String userId;
  final String title;
  final String description;
  final List<String> image;
  final String category;
  final String auctionId;
  final String owner;
  final double startPrice;
  final bool isAccepted;

  const AuctionEntities(
      {required this.auctionId,
      required this.owner,
      required this.isAccepted,
      required this.userId,
      required this.title,
      required this.description,
      required this.image,
      required this.category,
      required this.startPrice});

  @override
  List<Object> get props => [
        userId,
        title,
        description,
        image,
        category,
        startPrice,
        auctionId,
        isAccepted,
        owner
      ];
}

class OwnerEntities {
  final String id;
  final String name;

  OwnerEntities({required this.id, required this.name});
}
