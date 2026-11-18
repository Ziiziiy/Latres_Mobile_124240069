// poster.dart -> WIDGET gambar poster yang dipakai di Home, Favorit, Detail.
// Kalau gambar gagal dimuat, otomatis tampil ikon film (aplikasi tidak error).
import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  const Poster({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height ?? 200,
          color: Colors.grey[800],
          child: const Icon(Icons.movie),
        );
      },
    );
  }
}
