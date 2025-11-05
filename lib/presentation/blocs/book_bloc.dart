import 'package:book_search_bloc/data/models/book_model.dart';
import 'package:book_search_bloc/domain/usecases/save_book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/book.dart';
import '../../domain/usecases/search_books.dart';

abstract class BookEvent {}
class SearchBooksEvent extends BookEvent {
  final String query;
  SearchBooksEvent(this.query);
}
class SaveBooksEvent extends BookEvent {
  final BookModel book;
  SaveBooksEvent(this.book);
}

abstract class BookState {}
class BookInitial extends BookState {}
class BookLoading extends BookState {}
class BookLoaded extends BookState {
  final List<Book> books;
  BookLoaded(this.books);
}
class BookError extends BookState {
  final String message;
  BookError(this.message);
}

class BookBloc extends Bloc<BookEvent, BookState> {
  final SearchBooks searchBooks;
  final SaveBook saveBook;

  BookBloc(this.searchBooks, this.saveBook) : super(BookInitial()) {
    on<SearchBooksEvent>((event, emit) async {
      emit(BookLoading());
      try {
        final books = await searchBooks(event.query);
        emit(BookLoaded(books));
      } catch (e) {
        emit(BookError(e.toString()));
      }
    });

    on<SaveBooksEvent>((event, emit) async {
      emit(BookLoading());
      try {
        await saveBook(event.book);
        // emit(BookLoaded(books));
      } catch (e) {
        emit(BookError(e.toString()));
      }
    });
  }
}