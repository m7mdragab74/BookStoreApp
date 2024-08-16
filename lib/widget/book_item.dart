import 'package:flutter/material.dart';
import '../models/db_model.dart';

class BookListItem extends StatelessWidget {
  final Book book;
  final VoidCallback onDelete;

  const BookListItem({super.key, required this.book, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(15),
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Image.network(
          book.showImgUrl,
          height: 120,
          width: 120,
          fit: BoxFit.fill,
        ),
      ),
      title: Text(
        book.showBookName,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(
        'Author: ${book.showAuthorName}',
        style: const TextStyle(fontSize: 16),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_forever),
        iconSize: 40,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Delete Book",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: const Text(
                  "Are you sure you want to delete this book?",
                  style: TextStyle(fontSize: 20),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      onDelete();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
