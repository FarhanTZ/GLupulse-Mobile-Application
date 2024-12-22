class Reminder {
  String id;
  String message;
  DateTime time;
  bool isActive;

  Reminder({
    required this.id,
    required this.message,
    required this.time,
    required this.isActive,
  });

  // Convert model to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'time': time.toIso8601String(),
      'isActive': isActive,
    };
  }

  // Convert Firestore document to model
  factory Reminder.fromMap(Map<String, dynamic> map, String id) {
    return Reminder(
      id: id,
      message: map['message'],
      time: DateTime.parse(map['time']),
      isActive: map['isActive'],
    );
  }
}
