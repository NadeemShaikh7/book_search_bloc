import '../../domain/entities/book.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/book_api_service.dart';
import '../datasources/book_local_service.dart';
import '../models/book_model.dart';

class BookRepositoryImpl implements BookRepository {
  final BookApiService apiService;
  final BookLocalService localService;

  BookRepositoryImpl(this.apiService, this.localService);

  @override
  Future<List<Book>> searchBooks(String query) async {
    final models = await apiService.searchBooks(query);
    return models?.map((m) => Book(title: m.title, author: m.author, coverUrl: m.coverUrl)).toList() ?? [];
  }

  @override
  Future<void> saveBook(BookModel book) async {
    // final model = BookModel(title: book.title, author: book.author, coverUrl: book.coverUrl);
    await localService.saveBook(book);
  }
}