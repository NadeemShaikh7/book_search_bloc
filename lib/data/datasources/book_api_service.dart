import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/book_model.dart';

class BookApiService {
  Future<List<BookModel>?> searchBooks(String query) async {

    final url = Uri.https(
      'openlibrary.org',
      '/search.json',
      {
        'q': query,
        'page': '2',
        'limit': '10',
      },
    );

    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
            final data = json.decode(response.body);
            final docs = data['docs'] as List;
            return docs.map((json) => BookModel.fromJson(json)).toList();
          }
    } catch (e) {
      print(e);
      throw Exception('Failed to load books');
    }
    return null;
  }
}