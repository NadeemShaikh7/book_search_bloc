// Search screen stub
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/book_bloc.dart';
import '../widgets/book_tile.dart';
import '../widgets/shimmer_loader.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Finder')),
      body: Column(
        children: [
          TextField(
            controller: controller,
            onSubmitted: (query) {
              context.read<BookBloc>().add(SearchBooksEvent(query));
            },
            decoration: InputDecoration(hintText: 'Search books...'),
          ),
          Expanded(
            child: BlocBuilder<BookBloc, BookState>(
              builder: (context, state) {
                if (state is BookLoading) return ShimmerLoader();
                if (state is BookLoaded) {
                  return ListView.builder(
                    itemCount: state.books.length,
                    itemBuilder: (context, index) {
                      final book = state.books[index];
                      return BookTile(book: book);
                    },
                  );
                }
                if (state is BookError) return Center(child: Text(state.message));
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}