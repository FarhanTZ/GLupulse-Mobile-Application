// controllers/reminder_controller.dart
import 'dart:async';
import '../services/reminder_service.dart';
import '../services/notification_service.dart';

class ReminderController {
  final ReminderService _reminderService = ReminderService();
  final NotificationService _notificationService = NotificationService();

  // Cek pengingat setiap interval waktu
  Future<void> checkReminders() async {
    final reminders = await _reminderService.getReminders();
    for (var reminder in reminders) {
      if (reminder.isActive && reminder.time.isBefore(DateTime.now())) {
        // Menampilkan notifikasi jika waktu pengingat sudah tiba
        _notificationService.showNotification(reminder.id.hashCode, reminder.message);
        _reminderService.updateReminderStatus(reminder.id, false); // Non-aktifkan setelah ditampilkan
      }
    }
  }

  // Cek pengingat setiap 1 menit
  void startReminderCheck() {
    Timer.periodic(const Duration(minutes: 1), (timer) {
      checkReminders();
    });
  }
}
