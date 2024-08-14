class Book {
  int? _id;
  int? done;
  String? _bookTitle;
  String? _bookAuthor;
  String? _bookCoverUrl;

  Book(dynamic obj) {
    _id = obj['id'];
    done = obj['done'];
    _bookTitle = obj['bookTitle'];
    _bookAuthor = obj['bookAuthor'];
    _bookCoverUrl = obj['bookCoverUrl'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'done': done,
      'bookTitle': _bookTitle,
      'bookAuthor': _bookAuthor,
      'bookCoverUrl': _bookCoverUrl
    };
  }

  Book.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    done = map['done'];
    _bookTitle = map['bookTitle'];
    _bookAuthor = map['bookAuthor'];
    _bookCoverUrl = map['bookCoverUrl'];
  }

  int? get id => _id;
  String? get bookTitle => _bookTitle;
  String? get bookAuthor => _bookAuthor;
  String? get bookCoverUrl => _bookCoverUrl;
}
