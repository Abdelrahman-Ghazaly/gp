import '../../features/e_commerce/domain/entities/search_query_entity.dart';
import 'app_constants.dart';

class ApiConstants {
  static const String _baseUrl = 'http://10.0.2.2:5000/';

  //* Product End Points

  static const String _productBaseUrl = '${_baseUrl}product/';

  static const String popularFurnitureByCategoryPath = '${_productBaseUrl}view';

  static const String uploadFurniturePath = '${_productBaseUrl}upload';

  static String deleteFurniturePath(productId) =>
      '${_productBaseUrl}delete/$productId';

  //*Search End Points

  static const String _productSearchBaseUrl =
      '${_productBaseUrl}search/product/?';

  static String furnitureFromSearcByQueryhPath(String query) =>
      '${_productSearchBaseUrl}query=$query';

  static String furnitureFromSearcByCategory(Category category) =>
      '${_productSearchBaseUrl}category=${mapCategoryToString(category)}';

  static String furnitureFromSearcByMinPricePath(int minPrice) =>
      '${_productSearchBaseUrl}minPrice=$minPrice';

  static String furnitureFromSearcByMaxPricePath(int maxPrice) =>
      '${_productSearchBaseUrl}maxPrice=$maxPrice';

  static String furnitureFromSearcByPriceRangePath(
    int minPrice,
    int maxPrice,
  ) =>
      '${_productSearchBaseUrl}minPrice=$minPrice&maxPrice=$maxPrice';

  static String furnitureFromSearcByCategoryAndPricePath(
          CategoryQueryEntity categoryQueryEntity) =>
      '${_productSearchBaseUrl}category=${mapCategoryToString(categoryQueryEntity.category)}&minPrice=${categoryQueryEntity.minPrice}&maxPrice=${categoryQueryEntity.maxPrice}';

  //* User End Points

  static const String _userBaseUrl = '${_baseUrl}user/';

  static const String viewProfilePath = '${_userBaseUrl}view/profile/';
}

String mapCategoryToString(Category category) {
  switch (category) {
    case Category.bed:
      return 'bed';
    case Category.chair:
      return 'chair';
    case Category.sofa:
      return 'sofa';
    case Category.lamp:
      return 'lamp';
    case Category.table:
      return 'table';
    case Category.dresser:
      return 'dresser';
  }
}
