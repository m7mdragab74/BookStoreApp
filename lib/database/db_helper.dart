import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/db_model.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();

  static Database? _db;
  Future<Database> createDatabase() async {
    if (_db != null) {
      print('Database already exists.');
      return _db!;
    }
    String path = join(await getDatabasesPath(), 'FinalData.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        print('Creating database and tables...');
        return db.execute(
            'CREATE TABLE products(id INTEGER PRIMARY KEY AUTOINCREMENT,bookname TEXT,authorname TEXT,imgurl TEXT)');
      },
    );
    print('Database created successfully.');
    return _db!;
  }

  Future<int> insertBook(Book book) async {
    Database db = await createDatabase();
    print('Inserting book: $book');
    int result = await db.insert('products', book.toMap());
    print('Book inserted successfully with id: $result');
    return result;
  }

  Future<List<Map<String, dynamic>>> getBooks() async {
    Database db = await createDatabase();
    print('Fetching books from the database.');
    List<Map<String, dynamic>> books = await db.query('products');
    print('Fetched ${books.length} books from the database.');
    return books;
  }

  Future<int> deleteBook(int id) async {
    Database db = await createDatabase();
    print('Deleting book with id: $id');
    int result = await db.delete('products', where: 'id = ?', whereArgs: [id]);
    print('Book deleted successfully. Deleted $result record(s).');
    return result;
  }
}