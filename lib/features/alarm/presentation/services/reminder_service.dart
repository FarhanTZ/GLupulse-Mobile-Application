// services/reminder_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reminder.dart';

class ReminderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Menyimpan pengingat ke Firebase
  Future<void> addReminder(Reminder reminder) async {
    await _db.collection('reminders').add(reminder.toMap());
  }

  // Mengambil semua pengingat dari Firebase
  Future<List<Reminder>> getReminders() async {
    final snapshot = await _db.collection('reminders').get();
    return snapshot.docs
        .map((doc) => Reminder.fromMap(doc.data(), doc.id))
        .toList();
  }

  // Mengupdate status pengingat
  Future<void> updateReminderStatus(String id, bool isActive) async {
    await _db.collection('reminders').doc(id).update({'isActive': isActive});
  }
}
