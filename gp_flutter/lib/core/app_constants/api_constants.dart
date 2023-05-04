import '../../features/e_commerce/domain/entities/search_query_entity.dart';
import 'app_values.dart';

class ApiConstants {
  // Auction End Points

  static const String auctionBaseUrl = 'http://192.168.1.2:5000/auction';

  static const String auctionViewProductPath = '$auctionBaseUrl/view';
  static const String auctionUploadProductPath = '$auctionBaseUrl/upload';

  static String auctionDeleteProductPath(auctionId) =>
      '$auctionBaseUrl/delete/$auctionId';

  static String viewAuctionDataPath(auctionId) =>
      '$auctionBaseUrl/view/item/$auctionId';
  static String viewAuctionSearchDataPath(
          category, maxPrice, query, minPrice) =>
      '$auctionBaseUrl/search/auction/?maxPrice=$maxPrice&category=$category&query=$query&minPrice=$minPrice';

  static String auctionPidProductPath(productId, userId) =>
      '$auctionBaseUrl/pid/$productId/$userId';
  static const String _baseUrl = 'http://10.0.2.2:5000/';

  //* Product End Points

  static const String _productBaseUrl = '${_baseUrl}product/';

  static const String popularFurnitureByCategoryPath = '${_productBaseUrl}view';

  static const String uploadFurniturePath = '${_productBaseUrl}upload';

  static String deleteFurniturePath(productId) =>
      '${_productBaseUrl}delete/$productId';

  //* Search End Points

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

  //* Auth End Points

  static const String _authBaseUrl = '${_baseUrl}auth/';

  static const String logInPath = '${_authBaseUrl}login';

  static const String signUpPath = '${_authBaseUrl}signup';
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
    case Category.empty:
      return '';
  }
}
