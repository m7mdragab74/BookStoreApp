import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/db_model.dart';
import '../widget/add_book_botton.dart';
import '../widget/book_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> _books = [];
  DbHelper? db;

  @override
  void initState() {
    super.initState();
    db = DbHelper();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    var dbHelper = DbHelper();
    List<Map<String, dynamic>> books = await dbHelper.getBooks();
    setState(() {
      _books = books.map((book) => Book.fromMap(book)).toList();
    });
  }

  void _removeBook(int bookId) async {
    await db!.deleteBook(bookId);
    _fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddBookButton(onAddBook: _fetchBooks),
      appBar:  AppBar(
        title: const Text(
          'Available Books',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: BookList(books: _books, onRemoveBook: _removeBook),
    );
  }
}
