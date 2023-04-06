class ApiConstants {
  static const String auctionBaseUrl = 'http://localhost:5000/auction';

  static const String auctionViewProductPath = '$auctionBaseUrl/view';
  static const String auctionUploadProductPath = '$auctionBaseUrl/upload';

  static String auctionDeleteProductPath(productId) =>
      '$auctionBaseUrl/delete/$productId';

  static String auctionPidProductPath(productId, userId) =>
      '$auctionBaseUrl/pid/$productId/$userId';
}
