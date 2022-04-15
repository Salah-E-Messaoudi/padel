import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String userDataToMap(UserData data) => json.encode(data.toMap());

class UserData {
  UserData({
    this.init = false,
    this.uid = '',
    this.displayName,
    this.phoneNumber,
    this.gender,
    this.photoUrl,
    this.token,
    this.age,
    this.photo,
  });

  final bool init;
  final String uid;
  final String? displayName;
  final String? phoneNumber;
  final String? gender;
  final String? photoUrl;
  final String? token;
  final int? age;
  final ImageProvider<Object>? photo;

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
      age: json['age'],
      token: json['token'],
      photo: photo,
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
        age: json['age'],
        token: json['token'],
        photo: photo);
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
        photoUrl: json['photoUrl'],
        age: json['age'],
        token: json['token'],
        photo: photo,
      );

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'photoUrl': photoUrl,
        'age': age,
        'token': token,
      };

  bool get isNotComplete =>
      displayName == null || photoUrl == null || age == null || gender == null;
}
