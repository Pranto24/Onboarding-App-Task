import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:flutter/widgets.dart';

@pragma('vm:entry-point') // Required for AndroidAlarmManager isolate
void _alarmCallback() async {
  print('Alarm Triggered!');

  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings =
      InitializationSettings(android: androidSettings);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.initialize(initSettings);

  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'alarm_channel',
    'Alarm Notifications',
    channelDescription: 'This channel is used for alarm notifications',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('alarm_sound'), // Ensure file exists
  );

  const NotificationDetails platformDetails =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Alarm',
    'Time to wake up!',
    platformDetails,
  );
}

class ScheduleAlarmUseCase {
  Future<void> call(int id, DateTime dateTime) async {
    await AndroidAlarmManager.oneShotAt(
      dateTime,
      id,
      _alarmCallback,
      exact: true,
      wakeup: true,
    );
  }
}
