import '../../../../core/app_constants/app_constants.dart';

class CategoryQueryEntity {
  final Category category;
  final int minPrice;
  final int maxPrice;

  CategoryQueryEntity({
    required this.category,
    required this.minPrice,
    required this.maxPrice,
  });
}
