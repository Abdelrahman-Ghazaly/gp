class ApiConstants {
  // Base Url

  static const String _baseUrl = 'http://192.168.1.2:5000/';

  // Auction End Points

  static const String _auctionBaseUrl = '${_baseUrl}auction/';
  static const String auctionViewRequestsPath =
      '${_auctionBaseUrl}view/requests';
  static String viewAuctionDataPath(auctionId) =>
      '${_auctionBaseUrl}accept/$auctionId';
  static String auctionAcceptRequestsPath(auctionId) =>
      '${_auctionBaseUrl}accept/$auctionId';
  static String auctionRefuseRequestsPath(auctionId) =>
      '${_auctionBaseUrl}refuse/$auctionId';
  //* User End Points

  static const String _userBaseUrl = '${_baseUrl}user/';

  static const String viewProfilePath = '${_userBaseUrl}view/profile/';

  //* Auth End Points

  static const String _authBaseUrl = '${_baseUrl}admin/';

  static const String logInPath = '${_authBaseUrl}login';
}
