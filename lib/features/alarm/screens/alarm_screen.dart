import 'package:flutter/material.dart';
import 'package:onboardingapptask/features/alarm/model/alarm.dart';
import 'package:onboardingapptask/features/alarm/repository/alarm_repository.dart';

import 'package:permission_handler/permission_handler.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  final AlarmRepository _repository = AlarmRepository();

  List<Alarm> get alarms => _repository.getAlarms();

  Future<void> _addAlarm() async {
    // Request notification permission (Android 13+)
    var notifStatus = await Permission.notification.status;
    if (!notifStatus.isGranted) {
      notifStatus = await Permission.notification.request();
      if (!notifStatus.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification permission not granted!')),
        );
        return;
      }
    }

    // Request exact alarm scheduling permission (Android 12+)
    var alarmStatus = await Permission.scheduleExactAlarm.status;
    if (!alarmStatus.isGranted) {
      alarmStatus = await Permission.scheduleExactAlarm.request();
      if (!alarmStatus.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Exact alarm permission not granted!')),
        );
        return;
      }
    }

// Proceed with date/time picking only if permissions are granted
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    final newAlarm = Alarm(id: alarms.length + 1, dateTime: dateTime);

    setState(() {
      _repository.addAlarm(newAlarm);
    });
  }

  void _toggleAlarm(int id) {
    setState(() {
      _repository.toggleAlarm(id);
    });
  }

  String _formatTime(DateTime dt) => TimeOfDay.fromDateTime(dt).format(context);

  String _formatDate(DateTime dt) =>
      '${dt.day.toString().padLeft(2, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 120),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _addAlarm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E1E1E),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Add Alarm',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 56),
              const Text(
                'Alarms',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: alarms.isEmpty
                    ? const Center(
                        child: Text(
                          'No alarms set',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: alarms.length,
                        itemBuilder: (context, index) {
                          final alarm = alarms[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        _formatTime(alarm.dateTime),
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(width: 40),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          _formatDate(alarm.dateTime),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Switch(
                                    value: alarm.enabled,
                                    onChanged: (_) => _toggleAlarm(alarm.id),
                                    activeColor:
                                        const Color.fromARGB(255, 85, 75, 212),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
