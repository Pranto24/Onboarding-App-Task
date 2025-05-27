import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';    
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'package:onboardingapptask/features/onboarding/screens/onboarding_flow.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);


  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OnboardingFlow(),
      debugShowCheckedModeBanner: false,
    );
  }
}

