class ApiConstants {
  // Auction End Points

  static const String _baseUrl = 'http://192.168.1.2:5000/';

  //* User End Points

  static const String _userBaseUrl = '${_baseUrl}user/';

  static const String viewProfilePath = '${_userBaseUrl}view/profile/';

  //* Auth End Points

  static const String _authBaseUrl = '${_baseUrl}admin/';

  static const String logInPath = '${_authBaseUrl}login';
}
