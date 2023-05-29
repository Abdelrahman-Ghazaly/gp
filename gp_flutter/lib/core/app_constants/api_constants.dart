import '../../features/e_commerce/domain/entities/query_entity.dart';
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

  static String auctionBidProductPath(auctionId) =>
      '$auctionBaseUrl/bid/$auctionId';
  //'http://10.0.2.2:5000/'
  static const String _baseUrl = 'http://192.168.1.2:5000/';

  //* Product End Points

  static const String _productBaseUrl = '${_baseUrl}product/';

  static const String popularFurnitureByCategoryPath = '${_productBaseUrl}view';

  static String viewProductPathById(String id) =>
      '$popularFurnitureByCategoryPath/item/$id';

  static const String uploadFurniturePath = '${_productBaseUrl}upload';

  static String deleteFurniturePath(productId) =>
      '${_productBaseUrl}delete/$productId';

  //* Search End Points

  static const String _productSearchBaseUrl =
      '${_productBaseUrl}search/product/?';

  static String getFurnitureFromSearch(QueryEntity queryEntity) {
    String maxPrice = queryEntity.maxPrice.toInt() == 0
        ? ''
        : queryEntity.maxPrice.toInt().toString();
    String minPrice = queryEntity.minPrice.toInt() == 0
        ? ''
        : queryEntity.minPrice.toInt().toString();
    return '${_productSearchBaseUrl}category=${queryEntity.category.mapToString()}&query=${queryEntity.name}&minPrice=$minPrice&maxPrice=$maxPrice';
  }

  //* User End Points

  static const String _userBaseUrl = '${_baseUrl}user/';

  static const String viewProfilePath = '${_userBaseUrl}view/profile/';

  //* Auth End Points

  static const String _authBaseUrl = '${_baseUrl}auth/';

  static const String logInPath = '${_authBaseUrl}login';

  static const String signUpPath = '${_authBaseUrl}signup';
}
