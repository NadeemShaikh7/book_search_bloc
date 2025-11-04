import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/book_model.dart';
import '../../domain/entities/book.dart';
import '../blocs/book_bloc.dart';

class DetailsScreen extends StatefulWidget {
  final Book book;

  const DetailsScreen({super.key, required this.book});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  // late AnimationController _controller;
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(
  //     duration: const Duration(seconds: 2),
  //     vsync: this,
  //   )..repeat(); // Continuous rotation
  // }
  //
  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  Future<void> _saveBook() async {
    context.read<BookBloc>().add(SaveBooksEvent(BookModel(
      title: widget.book.title,
      author: widget.book.author,
      coverUrl: widget.book.coverUrl,
    )));
    // await _localService.saveBook(
    //   BookModel(
    //     title: widget.book.title,
    //     author: widget.book.author,
    //     coverUrl: widget.book.coverUrl,
    //   ),
    // );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Book saved locally!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: book.coverUrl.isNotEmpty
                  ? Image.network(book.coverUrl, height: 200)
                  : Icon(Icons.book, size: 200),
            ),
            const SizedBox(height: 24),
            Text(book.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('by ${book.author}', style: TextStyle(fontSize: 16)),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: _saveBook,
              icon: Icon(Icons.save),
              label: Text('Save Book'),
            ),
          ],
        ),
      ),
    );
  }
}