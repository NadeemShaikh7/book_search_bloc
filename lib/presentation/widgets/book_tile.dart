import 'package:flutter/material.dart';
import '../../domain/entities/book.dart';
import '../screens/details_screen.dart';

class BookTile extends StatelessWidget {
  final Book book;

  const BookTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: book.coverUrl.isNotEmpty
          ? Image.network(book.coverUrl, width: 50, fit: BoxFit.cover)
          : Icon(Icons.book, size: 50),
      title: Text(book.title),
      subtitle: Text(book.author),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsScreen(book: book),
          ),
        );
      },
    );
  }
}