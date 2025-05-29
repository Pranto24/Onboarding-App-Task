// alarm.dart
class Alarm {
  final int id;
  final DateTime dateTime;
  bool enabled;

  Alarm({
    required this.id,
    required this.dateTime,
    this.enabled = true,
  });
}
