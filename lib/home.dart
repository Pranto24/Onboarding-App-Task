import 'package:flutter/material.dart';

class AlarmApp extends StatelessWidget {
  const AlarmApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alarm App',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.white,
        colorScheme: ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const AlarmScreen(),
    );
  }
}

class Alarm {
  final String id;
  final TimeOfDay time;
  final DateTime date;
  bool enabled;

  Alarm({
    required this.id,
    required this.time,
    required this.date,
    this.enabled = true,
  });
}

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final List<Alarm> _alarms = [];

  Future<void> _addAlarm() async {
    // Get current date and time for default values
    final now = DateTime.now();

    // Show time picker
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    // Show date picker
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate == null) return;

    // Add new alarm to the list
    setState(() {
      _alarms.add(
        Alarm(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          time: pickedTime,
          date: pickedDate,
          enabled: true,
        ),
      );
    });
  }

  void _toggleAlarm(String id) {
    setState(() {
      final alarmIndex = _alarms.indexWhere((alarm) => alarm.id == id);
      if (alarmIndex != -1) {
        _alarms[alarmIndex].enabled = !_alarms[alarmIndex].enabled;
      }
    });
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'am' : 'pm';
    return '$hour:$minute $period';
  }

  String _formatDate(DateTime date) {
    final List<String> weekdays = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun'
    ];
    final List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    final String weekday =
        weekdays[date.weekday - 1]; // weekday is 1-7 where 1 is Monday
    final String day = date.day.toString().padLeft(2, '0');
    final String month = months[date.month - 1]; // month is 1-12
    final String year = date.year.toString();

    return '$weekday $day $month $year';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 200),
              // Add Alarm Button
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
                  child: const Text('Add Alarm'),
                ),
              ),
              const SizedBox(height: 100),

              // Alarms Section
              const Text(
                'Alarms',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 26),

              // Alarms List
              Expanded(
                  child: _alarms.isEmpty
                      ? const Center(
                          child: Text(
                            'No alarms set',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
  itemCount: _alarms.length,
  itemBuilder: (context, index) {
    final alarm = _alarms[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _formatTime(alarm.time),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 66),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    _formatDate(alarm.date),
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
              activeColor: const Color.fromARGB(255, 85, 75, 212),
            ),
          ],
        ),
      ),
    );
  },
)
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
