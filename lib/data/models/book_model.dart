class BookModel {
  final String title;
  final String author;
  final String coverUrl;

  BookModel({required this.title, required this.author, required this.coverUrl});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      title: json['title'] ?? 'No Title',
      author: (json['author_name'] as List?)?.first ?? 'Unknown Author',
      coverUrl: json['cover_i'] != null
          ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-M.jpg'
          : '',
    );
  }
}