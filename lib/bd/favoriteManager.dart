class FavoriteManager {
  /*Future<void> saveFavoriteAnimal(Pets animal, String user) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteJson = prefs.getString('favorites');
    if (favoriteJson != null) {
      final Map<String, dynamic> favoriteMap = json.decode(favoriteJson);
      final Favorite favorite = Favorite.fromJson(favoriteMap);
      favorite.list.add(animal);
      await prefs.setString('favorites', json.encode(favorite.toJson()));
    } else {
      final favorite = Favorite([animal], user);
      await prefs.setString('favorites', json.encode(favorite.toJson()));
    }
  }

  Future<Favorite?> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteJson = prefs.getString('favorites');
    if (favoriteJson != null) {
      final Map<String, dynamic> favoriteMap = json.decode(favoriteJson);
      final Favorite favorite = Favorite.fromJson(favoriteMap);
      return favorite;
    }
    return null;
  }*/
}
