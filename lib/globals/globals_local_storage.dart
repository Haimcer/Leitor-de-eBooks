import 'package:shared_preferences/shared_preferences.dart';

class GlobalsLocalStorage {
  Future<List<String>?> getFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? favoritos = prefs.getStringList('listFavorites');
    return favoritos;
  }

  Future<void> setFavorite({required List<String> listFavorite}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('listFavorites', listFavorite);
  }

  Future<void> setLocalDirectory(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String?> getLocalDirectory(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
