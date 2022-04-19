import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padel/functions.dart';
import 'package:padel/src/services_models/models.dart';

class FBNotification {
  FBNotification({
    required this.id,
    required this.user,
    required this.key,
    required this.createdAt,
    required this.path,
    required this.seen,
    required this.reference,
  });

  final String id;
  final UserMin user;
  final String key;
  final DateTime createdAt;
  final String? path;
  final bool seen;
  final DocumentReference reference;

  factory FBNotification.fromDocumentSnapshot(
    DocumentSnapshot doc,
  ) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return FBNotification(
      id: doc.id,
      user: json['user'],
      key: json['key'],
      createdAt: getDateTime(json['createdAt'])!,
      path: json['path'],
      seen: json['seen'],
      reference: doc.reference,
    );
  }

  Future<void> delete() async {
    await reference.delete();
  }
}
