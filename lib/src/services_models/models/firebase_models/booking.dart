import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/models.dart';

class Booking {
  Booking({
    required this.stadium,
    required this.owner,
    required this.createdAt,
    required this.startAt,
    required this.endAt,
    required this.active,
    required this.listphotoURL,
    required this.reference,
  });

  final StadiumMin stadium;
  final UserMin owner;
  final DateTime createdAt;
  final DateTime startAt;
  final DateTime endAt;
  final bool active;
  final List<ImageProvider<Object>> listphotoURL;
  final DocumentReference reference;

  factory Booking.fromDocumentSnapshot(
    DocumentSnapshot doc,
    DateTime now,
  ) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Booking(
      stadium: StadiumMin.fromMap(json['stadium']),
      owner: UserMin.fromMap(json['owner']),
      createdAt: getDateTime(json['createdAt'])!,
      startAt: getDateTime(json['startAt'])!,
      endAt: getDateTime(json['endAt'])!,
      active: getDateTime(json['endAt'])!.isAfter(now),
      listphotoURL: List<String>.from(json['list_photoURL'])
          .map((e) => CachedNetworkImageProvider(e))
          .toList(),
      reference: doc.reference,
    );
  }

  int get teamCount => listphotoURL.length;

  bool get isFull => stadium.type == 'padel' ? teamCount == 4 : teamCount == 11;
}
