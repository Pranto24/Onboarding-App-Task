import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onboardingapptask/main.dart';

void alarmCallback() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'alarm_channel',
    'Alarm Notifications',
    channelDescription: 'This channel is used for alarm notifications',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('alarm_sound'), // put alarm_sound.mp3 in android/app/src/main/res/raw/
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
