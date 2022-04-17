import 'package:padel/src/services_models/models.dart';

class StadiumMax {
  StadiumMax({
    required this.stadium,
    required this.availibility,
  });

  final StadiumMin stadium;
  final List<AvailibilityDay> availibility;

  factory StadiumMax.fromMap(Map<String, dynamic> json) => StadiumMax(
        stadium: StadiumMin.fromMap(json),
        availibility: List<AvailibilityDay>.from(
            json['availibility'].map((x) => AvailibilityDay.fromMap(x))),
      );
}

class AvailibilityDay {
  AvailibilityDay({
    required this.availableOn,
    required this.availableAt,
  });

  final DateTime availableOn;
  final List<AvailibilityHour> availableAt;

  factory AvailibilityDay.fromMap(Map<String, dynamic> json) => AvailibilityDay(
        availableOn: DateTime.parse(json['availableOn']),
        availableAt: List<AvailibilityHour>.from(
            json['availableAt'].map((x) => AvailibilityHour.fromMap(x))),
      );
}

class AvailibilityHour {
  AvailibilityHour({
    required this.startAt,
    required this.endAt,
  });

  final DateTime startAt;
  final DateTime endAt;

  factory AvailibilityHour.fromMap(Map<String, dynamic> json) =>
      AvailibilityHour(
        startAt: DateTime.parse(json['startAt']),
        endAt: DateTime.parse(json['endAt']),
      );
}
