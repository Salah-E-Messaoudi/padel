import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:padel/functions.dart';

class FBNotification {
  FBNotification({
    required this.id,
    required this.displayName,
    required this.key,
    required this.createdAt,
    required this.seen,
    required this.photo,
    required this.reference,
  });

  final String id;
  final String displayName;
  final String key;
  final DateTime createdAt;
  bool seen;
  final ImageProvider<Object> photo;
  final DocumentReference reference;

  factory FBNotification.fromDocumentSnapshot(
    DocumentSnapshot doc,
  ) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return FBNotification(
      id: doc.id,
      displayName: json['displayName'],
      key: json['key'],
      createdAt: getDateTime(json['createdAt'])!,
      seen: json['seen'],
      photo: CachedNetworkImageProvider(json['photoURL']),
      reference: doc.reference,
    );
  }

  Future<void> delete() async {
    await reference.delete();
  }

  Future<void> markAsSeen() async {
    if (seen) return;
    seen = true;
    reference.update({'seen': true});
  }
}
