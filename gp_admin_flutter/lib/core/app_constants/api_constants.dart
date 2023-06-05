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
  //* Report End Points

  static const String _reportBaseUrl = '${_baseUrl}report/';
  static const String viewReportsPath = '${_reportBaseUrl}view';
  static String acceptReportPath(reportId) =>
      '${_reportBaseUrl}accept/$reportId';
  static String refuseReportPath(reportId) =>
      '${_reportBaseUrl}refuse/$reportId';

  //* Auth End Points

  static const String _authBaseUrl = '${_baseUrl}admin/';

  static const String logInPath = '${_authBaseUrl}login';
}
