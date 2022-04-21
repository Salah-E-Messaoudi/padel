import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Friend {
  Friend({
    required this.uid,
    required this.displayName,
    required this.phoneNumber,
    required this.photoUrl,
    required this.token,
    required this.photo,
    required this.reference,
  });

  final String uid;
  final String displayName;
  final String phoneNumber;
  final String photoUrl;
  final String token;
  final ImageProvider<Object> photo;
  final DocumentReference reference;

  factory Friend.fromDocumentSnapshot(
    DocumentSnapshot doc,
  ) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Friend(
      uid: json['uid'],
      displayName: json['displayName'],
      phoneNumber: json['phoneNumber'],
      photoUrl: json['photoURL'],
      token: json['token'],
      // photo: Image.network(json['photoURL']).image,
      // photo: CachedNetworkImage(imageUrl: json['photoURL']),
      photo: CachedNetworkImageProvider(json['photoURL']),
      reference: doc.reference,
    );
  }

  Future<void> delete() async {
    await reference.delete();
  }
}
