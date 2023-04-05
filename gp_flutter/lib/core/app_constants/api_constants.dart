class ApiConstants {
  static const String baseUrl = 'http://localhost:5000/';

  //Product End Points

  static const String productBaseUrl = '${baseUrl}product/';

  static const String popularFurnitureByCategoryPath = '${productBaseUrl}view';

  static String furnitureFromSearcByQueryhPath(String query) =>
      '${productBaseUrl}search/search/product/?query=$query';

  static const String uploadFurniturePath = '${productBaseUrl}upload';

  static String deleteFurniturePath(productId) =>
      '${productBaseUrl}delete/$productId';

  //User End Points

  static const String userBaseUrl = '${baseUrl}user/';

  static const String viewProfilePath = '${userBaseUrl}view/profile/';
}
