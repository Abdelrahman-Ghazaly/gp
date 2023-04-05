import '../../features/e_commerce/domain/entities/search_query_entity.dart';
import 'app_constants.dart';

class ApiConstants {
  static const String _baseUrl = 'http://10.0.2.2:5000/';

  //? Product End Points

  static const String _productBaseUrl = '${_baseUrl}product/';

  static const String popularFurnitureByCategoryPath = '${_productBaseUrl}view';

  static const String uploadFurniturePath = '${_productBaseUrl}upload';

  static String deleteFurniturePath(productId) =>
      '${_productBaseUrl}delete/$productId';

  //? Search End Points

  static const String productSearchBaseUrl = '${_baseUrl}search/product/?';

  static String furnitureFromSearcByQueryhPath(String query) =>
      '${productSearchBaseUrl}query=$query';

  static String furnitureFromSearcByCategory(Category category) =>
      '${productSearchBaseUrl}category=$category';

  static String furnitureFromSearcByMinPricePath(int minPrice) =>
      '${productSearchBaseUrl}minPrice=$minPrice';

  static String furnitureFromSearcByMaxPricePath(int maxPrice) =>
      '${productSearchBaseUrl}maxPrice=$maxPrice';

  static String furnitureFromSearcByPriceRangePath(
    int minPrice,
    int maxPrice,
  ) =>
      '${productSearchBaseUrl}minPrice=$minPrice&maxPrice=$maxPrice';

  static String furnitureFromSearcByCategoryAndPricePath(
          CategoryQueryEntity categoryQueryEntity) =>
      '${productSearchBaseUrl}category=${categoryQueryEntity.category}&minPrice=${categoryQueryEntity.minPrice}&maxPrice=${categoryQueryEntity.maxPrice}';

  //? User End Points

  static const String _userBaseUrl = '${_baseUrl}user/';

  static const String viewProfilePath = '${_userBaseUrl}view/profile/';
}
