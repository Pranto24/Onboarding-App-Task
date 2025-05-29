import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

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

  static void _alarmCallback() {
    print('Alarm Triggered!');
    // You can integrate notifications or sound here
  }
}
