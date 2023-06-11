import '../../features/e_commerce/domain/entities/query_entity.dart';

class ApiConstants {
  //* Auction End Points

  static const String auctionBaseUrl = 'http://10.0.2.2:5000/auction';

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

  static const String furnitureFromUserId = '${_productBaseUrl}user/products';

  static String viewProductPathById(String id) =>
      '$popularFurnitureByCategoryPath/item/$id';

  static const String uploadFurniturePath = '${_productBaseUrl}upload';

  static String deleteFurniturePath(productId) =>
      '${_productBaseUrl}delete/$productId';

  static String reportFurniturePath(productId) =>
      '${_baseUrl}report/$productId';

  //* Search End Points

  static const String _productSearchBaseUrl =
      '${_productBaseUrl}search/product/?';

  static String getFurnitureFromSearch(QueryEntity queryEntity) {
    return '${_productSearchBaseUrl}category=${queryEntity.category}&query=${queryEntity.name}&minPrice=${queryEntity.minPrice}&maxPrice=${queryEntity.maxPrice}';
  }

  //* User End Points

  static const String _userBaseUrl = '${_baseUrl}user/';

  static String getUserNameUrl(String userId) => _userBaseUrl + userId;

  static String viewProfilePath(String userId) =>
      '${_userBaseUrl}view/profile/$userId';

  //* Auth End Points

  static const String _authBaseUrl = '${_baseUrl}auth/';

  static const String logInPath = '${_authBaseUrl}login';

  static const String signUpPath = '${_authBaseUrl}signup';

  //* Favorite End Points

  static const String _favoriteBaseUrl = '${_baseUrl}fav/';

  static String addFavoritePath({required String productId}) =>
      '${_favoriteBaseUrl}add/$productId';

  static String deleteFavoritePath({required String productId}) =>
      '${_favoriteBaseUrl}remove/$productId';

  static const String getFavoritePath = '${_favoriteBaseUrl}get';

  //* Chat End Points

  static const String socketUrl = 'http://10.0.2.2:5002/';

  static const String createConversationUrl = '${_baseUrl}conversation/';

  static String getConversationUrl(String userId) =>
      '${_baseUrl}conversation/$userId';

  static String getMessagesUrl(String conversationId) =>
      '${_baseUrl}message/$conversationId';

  static String sendMessageUrl = '${_baseUrl}message/';
}
