// khusus urusan HTTP (ambil & ubah data API)
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/show.dart';

String apiUrl = 'https://api.tvmaze.com/shows';

// Ambil semua show (JSON berbentuk List)
Future<List<Show>> getShows() async {
  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);
    return data.map((item) => Show.fromJson(item)).toList();
  } else {
    throw Exception('Gagal memuat show');
  }
}

// Ambil 1 show berdasarkan id (JSON berbentuk Map)
Future<Show> getSingleShow(int id) async {
  final response = await http.get(Uri.parse('$apiUrl/$id'));
  if (response.statusCode == 200) {
    return Show.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Gagal memuat detail show');
  }
}
