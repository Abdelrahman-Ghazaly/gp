import 'package:equatable/equatable.dart';

class QueryEntity extends Equatable {
  final String category;
  final String name;
  final String minPrice;
  final String maxPrice;

  const QueryEntity({
    this.category = '',
    this.name = '',
    this.minPrice = '',
    this.maxPrice = '',
  });

  @override
  List<Object?> get props => [
        category,
        name,
        minPrice,
        maxPrice,
      ];
}
