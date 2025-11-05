import 'package:book_search_bloc/data/datasources/book_api_service.dart';
import 'package:book_search_bloc/data/datasources/book_local_service.dart';
import 'package:book_search_bloc/data/repositories/book_repository_impl.dart';
import 'package:book_search_bloc/domain/usecases/save_book.dart';
import 'package:book_search_bloc/domain/usecases/search_books.dart';
import 'package:book_search_bloc/presentation/blocs/book_bloc.dart';
import 'package:book_search_bloc/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final BookApiService bookApiService =  BookApiService();
    final BookLocalService bookLocalService = BookLocalService();
    final BookRepositoryImpl bookRepositoryImpl = BookRepositoryImpl(bookApiService, bookLocalService);
    final SearchBooks searchBooks = SearchBooks(bookRepositoryImpl);
    final SaveBook saveBook = SaveBook(bookRepositoryImpl);
    return BlocProvider(
      create: (_) => BookBloc(searchBooks,saveBook),
      child: MaterialApp(
        title: 'Flutter With Bloc',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SearchScreen(),
      ),
    );
  }
}


