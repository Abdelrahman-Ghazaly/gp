import 'app_constants.dart';
import '../../features/e_commerce/domain/entities/search_query_entity.dart';

class ApiConstants {
  static const String baseUrl = 'http://localhost:5000/';

  //? Product End Points

  static const String productBaseUrl = '${baseUrl}product/';

  static const String popularFurnitureByCategoryPath = '${productBaseUrl}view';

  static const String uploadFurniturePath = '${productBaseUrl}upload';

  static String deleteFurniturePath(productId) =>
      '${productBaseUrl}delete/$productId';

  //? Search End Points

  static const String productSearchBaseUrl = '${baseUrl}search/product/?';

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

  static const String userBaseUrl = '${baseUrl}user/';

  static const String viewProfilePath = '${userBaseUrl}view/profile/';
}
