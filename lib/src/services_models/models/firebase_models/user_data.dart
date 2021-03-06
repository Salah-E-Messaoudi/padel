import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData {
  UserData({
    this.init = false,
    this.uid = '',
    this.displayName,
    this.phoneNumber,
    this.gender,
    this.photoUrl,
    this.token,
    this.birthDate,
    this.photo,
    this.odooId,
  });

  final bool init;
  final String uid;
  String? displayName;
  final String? phoneNumber;
  String? gender;
  String? photoUrl;
  final String? token;
  String? birthDate;
  ImageProvider<Object>? photo;
  int? odooId;

  factory UserData.fromUser(
    User user,
    DocumentSnapshot? doc,
    ImageProvider<Object>? photo,
  ) {
    Map<String, dynamic> json = (doc?.data() ?? {}) as Map<String, dynamic>;
    return UserData(
      uid: user.uid,
      displayName: user.displayName,
      phoneNumber: user.phoneNumber,
      gender: json['gender'],
      photoUrl: user.photoURL,
      birthDate: json['birthDate'],
      token: json['token'],
      photo: photo,
      odooId: json['odooId'],
    );
  }

  factory UserData.fromDocumentSnapshot(
    DocumentSnapshot doc,
    String photoUrl,
    ImageProvider<Object>? photo,
  ) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return UserData(
      uid: doc.id,
      displayName: json['displayName'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      photoUrl: photoUrl,
      birthDate: json['birthDate'],
      token: json['token'],
      photo: photo,
      odooId: json['odooId'],
    );
  }

  factory UserData.fromMap(
    Map<String, dynamic> json,
    String uid,
    String photoUrl,
    ImageProvider<Object>? photo,
  ) =>
      UserData(
        uid: uid,
        displayName: json['displayName'],
        phoneNumber: json['phoneNumber'],
        gender: json['gender'],
        photoUrl: json['photoURL'],
        birthDate: json['birthDate'],
        token: json['token'],
        photo: photo,
      );

  Map<String, dynamic> toUserMax() => {
        'uid': uid,
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'photoURL': photoUrl,
        'birthDate': birthDate,
        'token': token,
      };

  Map<String, dynamic> toUserMin() => {
        'uid': uid,
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        'photoURL': photoUrl,
        'token': token,
      };

  Map<String, String> toUserMinString() => {
        'uid': uid,
        'displayName': displayName!,
        'phoneNumber': phoneNumber!,
        'photoURL': photoUrl!,
        'token': token!,
      };

  bool get isNotComplete =>
      displayName == null ||
      photoUrl == null ||
      birthDate == null ||
      gender == null;

  void completeRegiration(
    String displayName,
    String photoUrl,
    String gender,
    String birthDate,
    int odooId,
  ) {
    this.displayName = displayName;
    this.gender = gender;
    this.photoUrl = photoUrl;
    this.birthDate = birthDate;
    this.odooId = odooId;
    photo = CachedNetworkImageProvider(photoUrl);
  }

  void updateProfile(
    String displayName,
    String? photoUrl,
    String gender,
    String birthDate,
  ) {
    this.displayName = displayName;
    this.gender = gender;
    if (photoUrl != null) {
      this.photoUrl = photoUrl;
      photo = CachedNetworkImageProvider(photoUrl);
    }
    this.birthDate = birthDate;
  }
}
