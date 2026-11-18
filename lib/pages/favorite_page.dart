import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorite_controller.dart';
import '../widgets/poster.dart';
import 'detail_page.dart';

class FavoritePage extends GetView<FavoriteController> {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.favorites.isEmpty) {
        return const Center(child: Text('Belum ada show favorit'));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: controller.favorites.length,
        itemBuilder: (context, index) {
          final fav = controller.favorites[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              onTap: () => Get.to(() => DetailPage(id: fav.id)),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Poster(url: fav.image, width: 40, height: 52),
              ),
              title: Text(fav.name, style: const TextStyle(fontSize: 13)),
              subtitle: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 13),
                  const SizedBox(width: 3),
                  Text(
                    fav.rating == 0 ? '-' : '${fav.rating}',
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
              trailing: IconButton(
                onPressed: () => controller.removeFavorite(fav.id),
                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              ),
            ),
          );
        },
      );
    });
  }
}
