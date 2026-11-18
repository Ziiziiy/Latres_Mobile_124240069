import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/favorite.dart';
import '../models/show.dart';

class FavoriteController extends GetxController {
  final box = Hive.box<FavoriteShow>('favorites');

  final favorites = <FavoriteShow>[].obs;

  @override
  void onInit() {
    loadFavorites();
    super.onInit();
  }

  void loadFavorites() {
    favorites.assignAll(box.values);
  }

  bool isFavorite(int id) {
    return favorites.any((fav) => fav.id == id);
  }

  void toggleFavorite(Show show) {
    if (isFavorite(show.id)) {
      removeFavorite(show.id);
    } else {
      box.put(
        show.id,
        FavoriteShow(
          id: show.id,
          name: show.name,
          image: show.image,
          rating: show.rating,
        ),
      );
      loadFavorites();
    }
  }

  void removeFavorite(int id) {
    box.delete(id);
    loadFavorites();
  }
}
