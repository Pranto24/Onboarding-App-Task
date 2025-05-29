import 'package:onboardingapptask/features/alarm/model/alarm.dart';
import 'package:onboardingapptask/features/alarm/domain/schedule_alarm_usecase.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

class AlarmRepository {
  final List<Alarm> _alarms = [];
  final ScheduleAlarmUseCase _scheduler = ScheduleAlarmUseCase();

  List<Alarm> getAlarms() => _alarms;

  void addAlarm(Alarm alarm) {
    _alarms.add(alarm);
    if (alarm.enabled) {
      _scheduler(alarm.id, alarm.dateTime);
    }
  }

  void toggleAlarm(int id) {
    final index = _alarms.indexWhere((a) => a.id == id);
    if (index != -1) {
      _alarms[index].enabled = !_alarms[index].enabled;
      if (_alarms[index].enabled) {
        _scheduler(_alarms[index].id, _alarms[index].dateTime);
      } else {
        AndroidAlarmManager.cancel(_alarms[index].id);
      }
    }
  }
}
