import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/book_model.dart';

class BookLocalService {
  Future<Database> get database async {
    final path = join(await getDatabasesPath(), 'books.db');
    return openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE books(title TEXT, author TEXT, coverUrl TEXT)',
      );
    });
  }

  Future<void> saveBook(BookModel book) async {
    final db = await database;
    await db.insert('books', {
      'title': book.title,
      'author': book.author,
      'coverUrl': book.coverUrl,
    });
  }
}