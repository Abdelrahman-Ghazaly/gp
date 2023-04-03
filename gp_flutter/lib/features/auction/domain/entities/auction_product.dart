import 'package:equatable/equatable.dart';

class AuctionProduct extends Equatable {
  final String userId;
  final String title;
  final String description;
  final String image;
  final String category;
  final double startPrice;
  final DateTime duration;
  final double currentPrice;

  const AuctionProduct({required this.userId,
    required this.title,
    required this.currentPrice,
    required this.description,
    required this.image,
    required this.category,
    required this.duration,
    required this.startPrice});

  @override
  List<Object> get props =>
      [
        userId,
        title,
        description,
        image,
        category,
        startPrice,
        duration,
        currentPrice,
      ];
}
