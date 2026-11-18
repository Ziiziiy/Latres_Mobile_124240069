// show.dart -> MODEL: cetakan data 1 show dari API TVMaze
class Show {
  final int id;
  final String name;
  final String image;
  final String imageBesar;
  final double rating;
  final List<String> genres;
  final String summary;

  Show({
    required this.id,
    required this.name,
    required this.image,
    required this.imageBesar,
    required this.rating,
    required this.genres,
    required this.summary,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    String gambar = json['image']?['medium'] ?? '';
    String gambarBesar = json['image']?['original'] ?? gambar;

    return Show(
      id: json['id'],
      name: json['name'],
      image: gambar.replaceFirst('http://', 'https://'),
      imageBesar: gambarBesar.replaceFirst('http://', 'https://'),
      rating: (json['rating']?['average'] ?? 0).toDouble(),
      genres: List<String>.from(json['genres'] ?? []),
      summary: (json['summary'] ?? '').replaceAll(RegExp(r'<[^>]*>'), ''),
    );
  }
}
