import 'package:equatable/equatable.dart';

import '../../../../core/app_constants/app_values.dart';

class QueryEntity extends Equatable {
  final Category? category;
  final String name;
  final double minPrice;
  final double maxPrice;

  const QueryEntity({
    this.category,
    this.name = '',
    this.minPrice = 0,
    this.maxPrice = 0,
  });

  @override
  List<Object?> get props => [
        category,
        name,
        minPrice,
        maxPrice,
      ];
}
