import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/show_controller.dart';
import '../widgets/poster.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShowController());

    return Obx(() {
      // 1. Loading
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // 2. Gagal
      if (controller.isError.value) {
        return Center(
          child: ElevatedButton(
            onPressed: controller.fetchShows,
            child: const Text('Gagal memuat. Coba lagi'),
          ),
        );
      }

      // 3. Berhasil -> grid
      return GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: controller.shows.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 kolom
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.58,
        ),
        itemBuilder: (context, index) {
          final show = controller.shows[index];

          return GestureDetector(
            onTap: () => Get.to(() => DetailPage(id: show.id)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.grey[900],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Poster(url: show.image, width: double.infinity),
                    ),
                    // Judul + rating
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            show.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 13),
                              const SizedBox(width: 3),
                              Text(
                                show.rating == 0 ? '-' : '${show.rating}',
                                style: const TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
