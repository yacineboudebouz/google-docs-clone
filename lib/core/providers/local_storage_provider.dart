import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localStorageProvider = Provider<LocalStorage>((ref) {
  throw Exception();
});

class LocalStorage {
  final String tokenKey = 'x-auth-token';
  final SharedPreferences _sharedPreferences;
  LocalStorage(
    SharedPreferences sharedPreferences,
  ) : _sharedPreferences = sharedPreferences;

  void storeToken(String token) {
    _sharedPreferences.setString(tokenKey, token);
  }

  String? getToken() {
    return _sharedPreferences.getString(tokenKey);
  }
}
