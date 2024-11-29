class Reminder {
  final String id;
  String title;
  String description;
  DateTime dateTime;
  String repeatType;
  bool isAlarmOn;
  String category;
  bool isDeleted;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.repeatType,
    required this.isAlarmOn,
    required this.category,
    this.isDeleted = false,
  });
}

