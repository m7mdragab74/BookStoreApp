import 'package:flutter/material.dart';

import '../models/db_model.dart';
import 'book_item.dart';

class BookList extends StatelessWidget {
  final List<Book> books;
  final Function(int) onRemoveBook;

  const BookList({super.key, required this.books, required this.onRemoveBook});

  @override
  Widget build(BuildContext context) {
    return books.isEmpty
        ? const Center(
      child: Text('No Books Available'),
    )
        : ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return BookListItem(
          book: books[index],
          onDelete: () => onRemoveBook(books[index].showBookId),
        );
      },
    );
  }
}
