import 'package:book_search_bloc/data/models/book_model.dart';

import '../entities/book.dart';

abstract class BookRepository {
  Future<List<Book>> searchBooks(String query);
  Future<void> saveBook(BookModel book);
}