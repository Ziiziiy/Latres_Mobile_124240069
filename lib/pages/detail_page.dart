import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_controller.dart';
import '../controllers/favorite_controller.dart';
import '../widgets/poster.dart';

class DetailPage extends StatelessWidget {
  final int id;

  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailController(id));
    final favoriteC = Get.find<FavoriteController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.isError.value) {
          return const Center(child: Text('Gagal memuat detail show.'));
        }

        final show = controller.show.value!;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Poster(
                url: show.imageBesar,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      show.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(show.rating == 0 ? '-' : '${show.rating}'),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      show.genres.isEmpty ? '-' : show.genres.join(', '),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),

                    // Tombol Nonton + tombol favorit
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 46,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Selamat menonton ${show.name}!')),
                                );
                              },
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Nonton'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Obx(() {
                          final sudahFavorit = favoriteC.isFavorite(show.id);
                          return InkWell(
                            onTap: () => favoriteC.toggleFavorite(show),
                            child: Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                sudahFavorit
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: sudahFavorit ? Colors.red : Colors.white,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      show.summary.isEmpty ? '-' : show.summary,
                      style: const TextStyle(fontSize: 12.5, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
