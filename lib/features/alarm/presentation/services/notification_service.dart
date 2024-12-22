// services/notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Inisialisasi notifikasi
  Future<void> initialize() async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Menampilkan notifikasi
  Future<void> showNotification(int id, String message) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    await _flutterLocalNotificationsPlugin.show(
      id,
      'Pengingat',
      message,
      notificationDetails,
    );
  }
}
