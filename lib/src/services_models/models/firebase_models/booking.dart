import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/models.dart';

class Booking {
  Booking({
    required this.stadium,
    required this.createdAt,
    required this.startAt,
    required this.endAt,
    required this.booked,
    required this.status,
    required this.reference,
  });

  final StadiumMin stadium;
  final DateTime createdAt;
  final DateTime startAt;
  final DateTime endAt;
  final int booked;
  final bool status;
  final DocumentReference reference;

  factory Booking.fromDocumentSnapshot(
    DocumentSnapshot doc,
    DateTime now,
  ) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Booking(
      stadium: StadiumMin.fromMap(json['stadium']),
      booked: json['booked'].toInt(),
      createdAt: getDateTime(json['createdAt'])!,
      startAt: getDateTime(json['startAt'])!,
      endAt: getDateTime(json['endAt'])!,
      status: getDateTime(json['startAt'])!.isAfter(now),
      reference: doc.reference,
    );
  }
}
