import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/services_models/services.dart';

class BookingMax {
  BookingMax({
    required this.id,
    required this.stadium,
    required this.owner,
    required this.createdAt,
    required this.details,
    required this.listAdded,
    required this.listInvited,
    required this.listURL,
    required this.reference,
  });

  final String id;
  final Stadium stadium;
  final UserMin owner;
  final DateTime createdAt;
  final BookingMin details;
  final List<String> listAdded;
  List<String> listInvited;
  final List<String> listURL;
  final DocumentReference reference;

  factory BookingMax.fromDocumentSnapshot(
    DocumentSnapshot doc,
    DateTime now,
  ) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return BookingMax(
      id: doc.id,
      stadium: Stadium.fromFullMap(json['stadium']),
      owner: UserMin.fromMap(json['owner']),
      createdAt: getDateTime(json['createdAt'])!,
      details: BookingMin.fromMap(json, now),
      listAdded: List<String>.from(json['list_added']),
      listInvited: List<String>.from(json['list_invited']),
      listURL: List<String>.from(json['list_photoURL']),
      reference: doc.reference,
    );
  }

  int get teamCount => listAdded.length;

  bool get isFull => false;

  bool isOwner(String uid) => owner.uid == uid;

  bool isAdded(String uid) => listAdded.contains(uid);

  bool isInvited(String uid) => listInvited.contains(uid);

  bool hasUser(String uid) =>
      listAdded.contains(uid) || listInvited.contains(uid);

  Future<void> inviteUser(String uid) async {
    listInvited.add(uid);
    await BookingsService.inviteUser(id, uid);
  }

  void undoInviteUser(String uid) {
    listInvited.remove(uid);
  }

  String get countText =>
      details.listphotoURL.length.toString() +
      '/' +
      (stadium.type == 'PADEL' ? '4' : '11');

  Map<String, dynamic> toBookingMinMap() => {
        'stadium': stadium.toMap(),
        'owner': owner.toMap(),
        'startAt': details.startAt,
        'endAt': details.endAt,
        'list_photoURL': listURL,
        'createdAt': FieldValue.serverTimestamp(),
      };
}
