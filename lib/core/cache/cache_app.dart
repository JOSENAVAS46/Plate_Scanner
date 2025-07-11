import 'package:flutter_dotenv/flutter_dotenv.dart';

class CacheApp {
  static final CacheApp _cacheAdmOperaciones = CacheApp._internal();

  factory CacheApp() => _cacheAdmOperaciones;

  CacheApp._internal();

  String _apiUrl = dotenv.get('API_LOCAL');

  void setApiUrl(String url) {
    _apiUrl = url;
  }

  String getApiUrl() {
    return _apiUrl;
  }
}
