import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padel/functions.dart';

class NotificationModel {
  NotificationModel({
    required this.uid,
    required this.displayname,
    required this.imageurl,
    required this.content,
    required this.time,
  });
  final String uid;
  final String displayname;
  final String imageurl;
  final String content;
  final DateTime time;

  factory NotificationModel.fromDocumentSnapshot(
    DocumentSnapshot doc,
    DateTime now,
  ) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      uid: json['uid'],
      displayname: json['displayname'],
      imageurl: json['imageurl'],
      content: json['content'],
      time: getDateTime(json['time'])!,
    );
  }
}
