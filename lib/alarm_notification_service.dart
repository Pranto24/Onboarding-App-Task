import 'package:flutter_local_notifications/flutter_local_notifications.dart';    
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';


void alarmCallback() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'alarm_channel',
      'Alarms',
      channelDescription: 'Channel for alarm notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound(
          'alarm_sound'), // Place in android/app/src/main/res/raw/
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Alarm',
      'Your alarm is ringing!',
      platformChannelSpecifics,
    );
  }

void scheduleAlarm(DateTime alarmTime) async {
  final int alarmId = alarmTime.millisecondsSinceEpoch ~/ 1000; // Unique ID

  await AndroidAlarmManager.oneShotAt(
    alarmTime,
    alarmId,
    alarmCallback,
    exact: true,
    wakeup: true,
  );
}
