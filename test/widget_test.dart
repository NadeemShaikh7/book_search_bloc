// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:book_search_bloc/data/repositories/book_repository_impl.dart';
import 'package:book_search_bloc/domain/entities/book.dart';
import 'package:book_search_bloc/domain/usecases/search_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:book_search_bloc/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'widget_test.mocks.dart';
@GenerateMocks([BookRepositoryImpl])
void main() {
    late SearchBooks usecase;
    late MockBookRepositoryImpl mockRepo;

    setUp(() {
      mockRepo = MockBookRepositoryImpl();
      usecase = SearchBooks(mockRepo);
    });

    test('should return list of books when search is successful', () async {
      final books = [Book(title: 'Test', author: 'Author', coverUrl: '')];
      when(mockRepo.searchBooks('Test')).thenAnswer((_) async => books);

      final result = await usecase('Test');

      expect(result, books);
      verify(mockRepo.searchBooks('Test'));
    });
}
