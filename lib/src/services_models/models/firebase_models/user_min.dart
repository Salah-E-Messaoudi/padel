import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserMin {
  UserMin({
    required this.uid,
    required this.displayName,
    required this.phoneNumber,
    required this.photoUrl,
    required this.token,
    required this.photo,
  });

  final String uid;
  final String displayName;
  final String phoneNumber;
  final String photoUrl;
  final String token;
  final ImageProvider<Object> photo;
  factory UserMin.fromMap(
    Map<String, dynamic> json,
  ) =>
      UserMin(
        uid: json['uid'],
        displayName: json['displayName'],
        phoneNumber: json['phoneNumber'],
        photoUrl: json['photoURL'],
        token: json['token'],
        photo: CachedNetworkImageProvider(json['photoURL']),
      );
}
