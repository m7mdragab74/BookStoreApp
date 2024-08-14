import 'package:book_store/models/db_model.dart';
import 'package:flutter/material.dart';

import '../database/db_helper.dart';
import '../widget/book_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    var dbHelper = DbHelper();
    List<Map<String, dynamic>> books = await dbHelper.getBooks();
    setState(() {
      _books = books.map((book) => Book.fromMap(book)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Available Books',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookForm(onBookSaved: _fetchBooks),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: _books.isEmpty
          ? const Center(child: Text('No books available'))
          : ListView.builder(
        itemCount: _books.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_books[index].bookTitle ?? 'No Title'),
            subtitle: Text(_books[index].bookAuthor ?? 'No Author'),
            trailing: Checkbox(
              value: _books[index].done == 1,
              onChanged: (bool? value) async {
                int newValue = value! ? 1 : 0;
                var dbHelper = DbHelper();
                await dbHelper.updateBookDone(_books[index].id!, newValue);
                setState(() {
                  _books[index].done = newValue;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
