import 'package:shared_preferences/shared_preferences.dart';

class GlobalsLocalStorage {
  Future<List<String>?> getFavorite({required String pageId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? favoritos = prefs.getStringList('listFavorites');
    return favoritos;
  }

  Future<void> setFavorite({required List<String> listFavorite}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('listFavorites', listFavorite);
  }
}
