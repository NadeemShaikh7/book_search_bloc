import 'package:book_search_bloc/data/models/book_model.dart';

import '../repositories/book_repository.dart';

class SaveBook {
  final BookRepository repository;

  SaveBook(this.repository);

  Future<void> call(BookModel book) {
    return repository.saveBook(book);
  }
}