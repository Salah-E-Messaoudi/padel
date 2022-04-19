import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/models.dart';

class PendingInvitation {
  PendingInvitation({
    required this.id,
    required this.stadium,
    required this.owner,
    required this.createdAt,
    required this.details,
    required this.reference,
  });

  final String id;
  final StadiumMin stadium;
  final UserMin owner;
  final DateTime createdAt;
  final BookingMin details;
  final DocumentReference reference;

  factory PendingInvitation.fromDocumentSnapshot(
    DocumentSnapshot doc,
    DateTime now,
  ) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return PendingInvitation(
      id: doc.id,
      stadium: StadiumMin.fromMap(json['stadium']),
      owner: UserMin.fromMap(json['owner']),
      createdAt: getDateTime(json['createdAt'])!,
      details: BookingMin.fromMap(json, now),
      reference: doc.reference,
    );
  }

  int get teamCount => details.teamCount;

  bool get isFull => stadium.type == 'padel' ? teamCount >= 4 : teamCount == 11;

  String get countText =>
      details.listphotoURL.length.toString() +
      '/' +
      (stadium.type == 'padel' ? '4' : '11');
}
