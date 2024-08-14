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
      print('Database already exists');
      return _db!;
    }
    String path = join(await getDatabasesPath(), 'ToDoOne.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        print('Creating Database and Tables');
        return db.execute(
            'CREATE TABLE Books1(id INTEGER PRIMARY KEY AUTOINCREMENT, done INTEGER, bookTitle TEXT, bookAuthor TEXT, bookCoverUrl TEXT)');
      },
    );
    print('Database Created Successfully');
    return _db!;
  }

  Future<int> deleteCourse(Book book) async {
    Database db = await createDatabase();
    return db.delete('Books1', where: 'id = ?', whereArgs: [book.id]);
  }

  Future<int> insertBook(Book book) async {
    Database db = await createDatabase();
    print('Inserting Books: $book');
    int result = await db.insert('Books1', book.toMap());
    print('Task inserted with id: $result');
    return result;
  }

  Future<List<Map<String, dynamic>>> getBooks() async {
    Database db = await createDatabase();
    print('Fetching Books from the database.');
    List<Map<String, dynamic>> books = await db.query('Books1');
    print('Fetched ${books.length} tasks from the database.');
    return books;
  }

  Future<int> updateBookDone(int id, int done) async {
    Database db = await createDatabase();
    print('Updating Book done with id: $id to $done');
    int result = await db.update(
      'Books1',
      {'done': done},
      where: 'id = ?',
      whereArgs: [id],
    );
    print('Task done updated successfully. Updated $result record(s).');
    return result;
  }
}
