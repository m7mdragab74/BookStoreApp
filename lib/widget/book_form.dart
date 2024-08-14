import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/db_model.dart';
import '../database/db_helper.dart';

class BookForm extends StatefulWidget {
  final VoidCallback onBookSaved;

  const BookForm({super.key, required this.onBookSaved});

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  String? bookTitle;
  String? bookAuthor;
  String? bookCoverUrl;
  int done = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(  // <-- Add Scaffold here
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0).copyWith(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Book Title'),
                    onChanged: (val) => setState(() => bookTitle = val),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Book Author'),
                    onChanged: (val) => setState(() => bookAuthor = val),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Book Cover Url'),
                    onChanged: (val) => setState(() => bookCoverUrl = val),
                  ),
                  const SizedBox(height: 37),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)
                        ),
                      ),
                      onPressed: () async {
                        if (bookTitle == null ||
                            bookAuthor == null ||
                            bookCoverUrl == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields'),
                            ),
                          );
                        } else {
                          Book book = Book({
                            'bookTitle': bookTitle,
                            'bookAuthor': bookAuthor,
                            'bookCoverUrl': bookCoverUrl,
                            'done': done,
                          });

                          var dbHelper = DbHelper();
                          try {
                            await dbHelper.insertBook(book);
                            widget.onBookSaved(); // Call the callback after saving
                            Navigator.of(context).pop(); // Close the form
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        }
                      },
                      child: const Text(
                        'ADD',
                        style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 19),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
