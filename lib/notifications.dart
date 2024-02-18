import 'package:timezone/data/latest.dart' as tz;
import 'package:mis_lab3/models/Appointment.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@drawable/ic_stat_circle_notifications');

    DarwinInitializationSettings iosInitializationSettings =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'channelId',
      'channelName',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );

    const DarwinNotificationDetails iosNotificationDetails =
    DarwinNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required List<Appointment> appointments,
  }) async {
    final details = await _notificationDetails();

    DateTime currentDate = DateTime.now();
    List<Appointment> appointmentsForCurrentDate = appointments
        .where(
          (appointment) =>
      appointment.date == DateFormat('yyyy-MM-dd').format(currentDate),
    )
        .toList();

    if (appointmentsForCurrentDate.isNotEmpty) {
      await _localNotificationService.show(id, title, body, details);
    }
  }
}