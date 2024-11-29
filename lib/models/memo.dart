class Memo {
  final String id;
  String title;
  String content;
  String category;
  bool isDeleted;

  Memo({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    this.isDeleted = false,
  });
}

