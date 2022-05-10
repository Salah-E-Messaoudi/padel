import 'package:intl/intl.dart';

class AvailableTime {
  final bool available;
  final DateTime startAt;
  final DateTime endAt;

  AvailableTime({
    required this.available,
    required this.startAt,
    required this.endAt,
  });

  factory AvailableTime.fromTime(
    bool available,
    int hoursStartAt,
  ) {
    DateTime now = DateTime.now();
    return AvailableTime(
      available: available,
      startAt: DateTime(
        now.year,
        now.month,
        now.day,
        hoursStartAt,
        0,
        0,
        0,
        0,
      ),
      endAt: DateTime(
        now.year,
        now.month,
        now.day,
        hoursStartAt + 1,
        0,
        0,
        0,
        0,
      ),
    );
  }

  String get time =>
      DateFormat('HH:mm').format(startAt) +
      ' - ' +
      DateFormat('HH:mm').format(endAt);

  DateTime getStartAt(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      startAt.hour,
      0,
      0,
      0,
      0,
    );
  }

  DateTime getEndAt(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      endAt.hour,
      0,
      0,
      0,
      0,
    );
  }
}
