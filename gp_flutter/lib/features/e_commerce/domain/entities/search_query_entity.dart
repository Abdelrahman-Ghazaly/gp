import 'package:equatable/equatable.dart';

import '../../../../core/app_constants/app_constants.dart';

class CategoryQueryEntity extends Equatable {
  final Category category;
  final int minPrice;
  final int maxPrice;

  const CategoryQueryEntity({
    required this.category,
    required this.minPrice,
    required this.maxPrice,
  });

  @override
  List<Object?> get props => [
        category,
        minPrice,
        maxPrice,
      ];
}
